#!/usr/bin/env crystal

require "admiral"
require "./smi/*"
require "./crstat/*"

class CrStatCLI < Admiral::Command
  define_version CrStat::VERSION
  define_help description: "fetching system info"

  def run
    puts "Welcome to CRSTAT v#{CrStat::VERSION}"
    Smi.run
  end
end

CrStatCLI.run
