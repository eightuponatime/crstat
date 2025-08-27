module CrStat::Cpu::Entities
  struct CpuInfo
    property temperature : Float64?

    def initialize(@temperature : Float64?)
    end
  end
end
