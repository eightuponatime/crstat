require "./fetchers/*"
require "./entities/cpu_info"

module CrStat::Cpu
  class CpuFetcher
    include CrStat::Cpu::Fetchers
    include CrStat::Cpu::Entities

    def fetch
      temperature = fetch_temperature()
      model_name = fetch_params()

      cpu_info = CpuInfo.new(
        temperature: temperature,
        model_name: model_name
      )

      cpu_info
    end
  end
end
