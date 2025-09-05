module CrStat::Mem::Entities
  struct RamModel
    property mem_total : Int32,
      mem_free : Int32

    def initialize(
      @mem_total : Int32,
      @mem_free : Int32,
    )
    end
  end
end
