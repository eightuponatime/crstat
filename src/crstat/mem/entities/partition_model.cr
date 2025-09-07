module CrStat::Mem::Entities
  struct PartitionModel
    property name : String,
      size : Float64,
      used : Float64,
      available : Float64,
      usage_pct : Float64,
      mounted_on : String

    def initialize(
      @name : String,
      @size : Float64,
      @used : Float64,
      @available : Float64,
      @usage_pct : Float64,
      @mounted_on : String,
    )
    end
  end
end
