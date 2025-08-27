#!/usr/bin/env crystal

require "admiral"
require "./crstat/*"

class CrStatCLI < Admiral::Command
  include CrStat
  define_version VERSION
  define_help description: "fetching system info"

  def run
    puts "Welcome to CRSTAT v#{CrStat::VERSION}"
    help
  end
end

CrStatCLI.run
