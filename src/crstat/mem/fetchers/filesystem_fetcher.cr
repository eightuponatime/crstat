require "../entities/*"

module CrStat::Mem::Fetchers
  include CrStat::Mem::Entities

  def fetch_filesystem
    path = "/proc/self/mountinfo"
    filesystems = [] of Tuple(String, String)
    File.each_line(path) do |line|
      words = line.split
      filesystem_name = ""
      mount_point = ""
      # conditions to store only real user disks
      next if words[9].starts_with?("/dev/loop") ||
              words[8] == "squashfs" ||
              words[8] == "vfat"

      if words[9].starts_with?("/dev")
        filesystem_name = words[9] # ex: /dev/nvme0n1p6
        mount_point = words[4]     # ex: /
        filesystems << {filesystem_name, mount_point}
      end
    end
    filesystems
  end

  def fetch_filesystem_info
    filesystems = fetch_filesystem
    result = [] of FilesystemModel
    filesystems.each do |fs_name, mount_point|
      stat = LibC::StatVfs.new

      if LibC.statvfs(mount_point, pointerof(stat)) == 0
        total = stat.f_blocks * stat.f_frsize / 1024
        used = (stat.f_blocks - stat.f_bfree) * stat.f_frsize / 1024
        available = stat.f_bavail * stat.f_frsize / 1024
        usage_pct = total > 0 ? (used.to_f / total * 100).round(2) : 0.0

        result << FilesystemModel.new(
          filesystem: fs_name,
          size: total,
          used: used,
          available: available,
          usage_pct: usage_pct,
          mount_point: mount_point
        )
      else
        puts "statvfs error: #{Errno.value}"
      end
    end
    result
  end
end
