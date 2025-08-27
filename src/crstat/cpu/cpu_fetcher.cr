module CrStat::Cpu
  class CpuFetcher
    include CrStat::Cpu::Fetchers::TemperatureFetcher
    def fetch 
      temperature : Float64 = fetch_temperature()      
    end
  end
end