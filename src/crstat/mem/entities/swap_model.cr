module CrStat::Mem::Entities
  struct SwapModel
    property swap_total : Int32,
      swap_free : Int32

    def initialize(
      @swap_total : Int32,
      @swap_free : Int32,
    )
    end
  end
end
