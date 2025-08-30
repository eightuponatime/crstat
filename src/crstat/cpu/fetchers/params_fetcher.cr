module CrStat::Cpu::Fetchers
  def fetch_params : String
    model_name : String = ""

    path = "/proc/cpuinfo"
    File.each_line(path) do |line|
      words = line.split
      next if words.empty?

      if line.starts_with?("model name")
        return words[3..].join(" ")
      end
    end

    ""
  end
end
