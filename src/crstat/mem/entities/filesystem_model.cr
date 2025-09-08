module CrStat::Mem::Entities
  struct PartitionModel
    property filesystem : String,
      type : String,
      size : Int64,
      used : Int64,
      available : Int64,
      usage_pct : Float64,
      mount_point : String,

    def initialize(
      @filesystem : String,
      @type : String,
      @size : Int64,
      @used : Int64,
      @available : Int64,
      @usage_pct : Float64,
      @mount_point : String,
    )
    end
  end
end
