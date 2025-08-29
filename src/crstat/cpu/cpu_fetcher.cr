require "./fetchers/temperature_fetcher"
require "./entities/cpu_info"

module CrStat::Cpu
  class CpuFetcher
    include CrStat::Cpu::Fetchers::TemperatureFetcher
    include CrStat::Cpu::Entities

    @temperature : String? = nil

    def initialize(
      @temperature : String? = nil,
    )
    end

    def fetch
      @temperature = fetch_temperature()

      cpu_info = CpuInfo.new(temperature: @temperature)

      cpu_info
    end
  end
end
