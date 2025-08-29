module CrStat::Cpu::Fetchers::TemperatureFetcher
  def fetch_temperature
    temp_file : String = "/sys/class/thermal/thermal_zone0/temp"
    content = File.read(temp_file)
    temperature : Float64 = (content.gsub("\n", "").to_f / 1000.0).round(2)
    result : String = "#{temperature}°C"
    result
  end
end
