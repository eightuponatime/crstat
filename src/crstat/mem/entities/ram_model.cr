module CrStat::Mem::Entities
  struct RamModel
    property mem_total : Float64,
      mem_available : Float64

    def initialize(
      @mem_total : Float64,
      @mem_available : Float64,
    )
    end
  end
end
