module CrStat::Cpu::Entities
  # CpuLoadModel is a CPU time breakdown model.
  # A model to store the amount of time the CPU has spent from
  # performing different kinds of work since the kernel start
  # from file /proc/stat
  struct CpuLoadModel
    getter user : Int64,
      nice : Int64,
      system : Int64,
      idle : Int64,
      iowait : Int64,
      irq : Int64,
      softirq : Int64,
      steal : Int64?,     # >= Linux 2.6.11
      guest : Int64?,     # >= Linux 2.6.24
      guest_nice : Int64? # >= Linux 2.6.33

    def initialize(
      @user : Int64,
      @nice : Int64,
      @system : Int64,
      @idle : Int64,
      @iowait : Int64,
      @irq : Int64,
      @softirq : Int64,
      @steal : Int64?,
      @guest : Int64?,
      @guest_nice : Int64?,
    )
    end
  end
end
