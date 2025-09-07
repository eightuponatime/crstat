module CrStat::Mem::Entities
  struct SwapModel
    property swap_total : Float64,
      swap_free : Float64

    def initialize(
      @swap_total : Float64,
      @swap_free : Float64,
    )
    end
  end
end
