#!/usr/bin/env crystal

require "../entities/*"

module CrStat::Mem::Fetchers
  include CrStat::Mem::Entities
  include Math

  def fetch_swap : SwapModel
    path = "/proc/meminfo"
    swap_total : Float64 = 0.0
    swap_free : Float64 = 0.0
    words = [] of String
    File.each_line(path) do |line|
      words = line.split

      if line.starts_with?("SwapTotal")
        swap_total = words[1].to_i64 / (1024 ** 2)
      end

      if line.starts_with?("SwapFree")
        swap_free = words[1].to_i64 / (1024 ** 2)
      end
    end

    SwapModel.new(swap_total: swap_total, swap_free: swap_free)
  end
end

class Runner
  include CrStat::Mem::Fetchers
end

runner = Runner.new.fetch_swap
