module CrStat::Cpu::Entities
  struct CpuUsageModel
    property total_pct : Float64,
      user_pct : Float64,
      nice_pct : Float64,
      system_pct : Float64,
      idle_pct : Float64,
      iowait_pct : Float64,
      irq_pct : Float64,
      softirq_pct : Float64,
      steal_pct : Float64?,
      guest_pct : Float64?,
      guest_nice_pct : Float64?

    def initialize(
      @total_pct : Float64,
      @user_pct : Float64,
      @nice_pct : Float64,
      @system_pct : Float64,
      @idle_pct : Float64,
      @iowait_pct : Float64,
      @irq_pct : Float64,
      @softirq_pct : Float64,
      @steal_pct : Float64?,
      @guest_pct : Float64?,
      @guest_nice_pct : Float64?,
    )
    end
  end
end
