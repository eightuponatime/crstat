require "./fetchers/*"
require "./entities/cpu_info"

module CrStat::Cpu
  class CpuFetcher
    include CrStat::Cpu::Fetchers
    include CrStat::Cpu::Entities

    def fetch
      temperature : String = fetch_temperature()
      model_name : String = fetch_params()
      cpu_threads_usage : Array(Float64) = fetch_cpu_usage()

      cpu_info = CpuInfo.new(
        temperature: temperature,
        model_name: model_name,
        cpu_threads_usage: cpu_threads_usage
      )

      cpu_info
    end
  end
end
