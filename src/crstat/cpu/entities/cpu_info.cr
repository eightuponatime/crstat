module CrStat::Cpu::Entities
  struct CpuInfo
    property model_name : String?
    property temperature : String?

    def initialize(
      @model_name : String? = nil,
      @temperature : String? = nil,
    )
    end
  end
end
