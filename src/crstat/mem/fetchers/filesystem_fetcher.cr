#!/usr/bin/env crystal

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
      puts "block --> #{fs_name}"
      stat = LibC::StatVfs.new

      if LibC.statvfs(fs_name, pointerof(stat)) == 0
        puts "block size --> #{stat.f_bsize}"
        puts "blocks amount --> #{stat.f_blocks}"
        puts "free blocks --> #{stat.f_bfree}"
        puts "available blocks --> #{stat.f_bavail}"
        puts "file name max length #{stat.f_namemax}"
      else
        puts "statvfs error: #{Errno.value}"
      end
    end
  end
end

class Runner
  include CrStat::Mem::Fetchers
end

runner = Runner.new.fetch_filesystem_info
