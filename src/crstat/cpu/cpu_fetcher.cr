require "./fetchers/*"
require "./entities/cpu_info"

module CrStat::Cpu
  class CpuFetcher
    include CrStat::Cpu::Fetchers
    include CrStat::Cpu::Entities

    def fetch
      load_fetcher_channel = Channel(Array(CpuUsageModel)).new

      # fiber to send [cpu_threads_usage] to the SMI by [load_fetcher_channel]
      spawn do
        cpu_threads_usage : Array(CpuUsageModel) = fetch_cpu_usage()
        load_fetcher_channel.send(cpu_threads_usage)
      end

      temperature : String = fetch_temperature()
      model_name : String = fetch_params()

      cpu_threads_usage : Array(CpuUsageModel) = load_fetcher_channel.receive

      cpu_info = CpuInfo.new(
        temperature: temperature,
        model_name: model_name,
        cpu_threads_usage: cpu_threads_usage
      )

      cpu_info
    end
  end
end
