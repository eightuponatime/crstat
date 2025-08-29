module CrStat::Cpu::Entities
  struct CpuInfo
    property temperature : String?

    def initialize(@temperature : String?)
    end
  end
end
