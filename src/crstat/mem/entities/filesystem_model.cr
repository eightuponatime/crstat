module CrStat::Mem::Entities
  struct FilesystemModel
    property filesystem : String
    property size : Float64
    property used : Float64
    property available : Float64
    property usage_pct : Float64
    property mount_point : String

    def initialize(
      @filesystem : String,
      @size : Float64,
      @used : Float64,
      @available : Float64,
      @usage_pct : Float64,
      @mount_point : String,
    )
    end
  end
end
