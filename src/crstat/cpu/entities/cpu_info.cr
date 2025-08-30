module CrStat::Cpu::Entities
  struct CpuInfo
    property model_name : String
    property temperature : String
    property cpu_threads_usage : Array(CpuUsageModel)

    def initialize(
      @model_name : String,
      @temperature : String,
      @cpu_threads_usage : Array(CpuUsageModel),
    )
    end
  end
end
