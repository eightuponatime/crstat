#!/usr/bin/env crystal

require "admiral"
require "./crstat/*"
require "./crstat/cpu/*"
require "./crstat/cpu/entities/*"

class CrStatCLI < Admiral::Command
  include CrStat
  include CrStat::Cpu

  define_version VERSION
  define_help description: "fetching system info"

  def run
    puts "Welcome to CRSTAT v#{CrStat::VERSION}"
    cpu_info = CpuFetcher.new.fetch
    p cpu_info
  end
end

CrStatCLI.run
