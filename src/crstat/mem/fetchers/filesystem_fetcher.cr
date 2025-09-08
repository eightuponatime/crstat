#!/usr/bin/env crystal

require "../entities/*"

module CrStat::Mem::Fetchers
  def fetch_filesystem
    path = "/proc/self/mountinfo"
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
      end
    end
  end
end

class Runner
  include CrStat::Mem::Fetchers
end

runner = Runner.new.fetch_filesystem
