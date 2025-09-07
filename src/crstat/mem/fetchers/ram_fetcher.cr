#!/usr/bin/env crystal

require "../entities/*"

module CrStat::Mem::Fetchers
  include CrStat::Mem::Entities
  include Math

  def fetch_ram : RamModel
    path = "/proc/meminfo"
    mem_total : Float64 = 0.0
    mem_available : Float64 = 0.0
    words = [] of String
    File.each_line(path) do |line|
      words = line.split

      if line.starts_with?("MemTotal")
        mem_total = (words[1].to_i64 / (1024 ** 2))
      end

      if line.starts_with?("MemAvailable")
        mem_available = (words[1].to_i64 / (1024 ** 2))
      end
    end

    p RamModel.new(mem_total: mem_total, mem_available: mem_available)
  end
end

class Runner
  include CrStat::Mem::Fetchers
end

runner = Runner.new.fetch_ram
