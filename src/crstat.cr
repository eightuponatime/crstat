#!/usr/bin/env crystal

require "admiral"
require "./crstat/*"
require "./crstat/cpu/*"
require "./crstat/cpu/entities/*"
require "./res/*"

class CrStatCLI < Admiral::Command
  include CrStat
  include CrStat::Cpu
  include CrStat::Cpu::Entities
  include Resources::Color
  include Resources::String

  define_version VERSION
  define_help description: "fetching system info"

  def crstat_smi
    loop do
      cpu_info = CpuFetcher.new.fetch
      print "\033[2J\033[H"
      # cpu name + space + vert separator + space + load indicator width + (5+2% + 1 space)
      screen_width = 5 + 3 + 50 + 8
      puts Resources::String::SEPARATOR * screen_width

      puts "CPU Model: #{cpu_info.model_name}"
      puts "Temperature: #{cpu_info.temperature}"

      puts Resources::String::SEPARATOR * screen_width

      cpu_info.cpu_threads_usage.each_with_index do |thread, index|
        puts "CPU#{index} | #{buildCpuLoadIndicator(thread)}"
      end

      puts Resources::String::SEPARATOR * screen_width
      puts "Updated at: #{Time.local}"
      sleep 2.second
    end
  end

  def buildCpuLoadIndicator(cpu : CpuUsageModel) : String
    max_capacity = 50

    parts = {
      Resources::Color::USER_CLR       => cpu.user_pct,
      Resources::Color::SYSTEM_CLR     => cpu.system_pct,
      Resources::Color::IRQ_CLR        => cpu.irq_pct,
      Resources::Color::SOFTIRQ_CLR    => cpu.softirq_pct,
      Resources::Color::STEAL_CLR      => cpu.steal_pct,
      Resources::Color::GUEST_CLR      => cpu.guest_pct,
      Resources::Color::GUEST_NICE_CLR => cpu.guest_nice_pct,
      Resources::Color::NICE_CLR       => cpu.nice_pct,
    }

    indicator : String = ""

    total_count : Int32 = 0

    parts.each do |color, pct|
      next if pct.nil? || pct <= 0
      count : Int32 = (pct * max_capacity / 100).round.to_i
      total_count += count
      indicator += "#{color}#{Resources::String::LOAD_INDICATOR_CHILD * count}"
    end

    empty_count = max_capacity - total_count
    indicator += " " * empty_count

    indicator += "#{Resources::Color::RESET} #{sprintf("%5.2f", cpu.total_pct)}%"

    indicator
  end

  def run
    puts "Welcome to CRSTAT v#{CrStat::VERSION}"
    crstat_smi()
  end
end

CrStatCLI.run
