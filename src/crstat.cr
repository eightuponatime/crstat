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

  def crstat_smi
    loop do
      cpu_info = CpuFetcher.new.fetch
      print "\033[2J\033[H"
      puts "==================== CRSTAT-SMI ===================="
      puts "CPU Model: #{cpu_info.model_name}"
      puts "Temperature: #{cpu_info.temperature}"
      puts "----------------------------------------------------"
      puts "Thread | Total% | User% | Sys% | Idle% | IOwait% | IRQ% | SoftIRQ% | Steal% | Guest% | GuestNice%"
      puts "----------------------------------------------------"
      cpu_info.cpu_threads_usage.each_with_index do |thread, idx|
        printf "%-6s | %6.2f | %5.2f | %4.2f | %5.2f | %7.2f | %4.2f | %7.2f  | %6.2f | %6.2f | %9.2f\n",
          "CPU#{idx}",
          thread.total_pct,
          thread.user_pct,
          thread.system_pct,
          thread.idle_pct,
          thread.iowait_pct,
          thread.irq_pct,
          thread.softirq_pct,
          thread.steal_pct,
          thread.guest_pct,
          thread.guest_nice_pct
      end
      puts "----------------------------------------------------"
      puts "Updated at: #{Time.local}"
      sleep 2.second
    end
  end

  def run
    puts "Welcome to CRSTAT v#{CrStat::VERSION}"
    crstat_smi()
  end
end

CrStatCLI.run
