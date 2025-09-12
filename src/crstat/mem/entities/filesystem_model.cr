module CrStat::Mem::Entities
  struct FilesystemModel
    property filesystem : String
    property size : Int64
    property used : Int64
    property available : Int64
    property usage_pct : Float64
    property mount_point : String

    def initialize(
      @filesystem : String,
      @size : Int64,
      @used : Int64,
      @available : Int64,
      @usage_pct : Float64,
      @mount_point : String
    )
    end
  end
end
