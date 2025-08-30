require "../entities/*"

module CrStat::Cpu::Fetchers
  include CrStat::Cpu::Entities

  # get the array of % values of cpu usage for each CPU thread
  def fetch_cpu_usage : Array(CpuUsageModel)
    # /proc/stat stores values that are cumulative time values
    # since the kernel start.
    # that's why here finding values with a gap of 1 second to subtract values
    # and only than we can find out the core load, because reading one file
    # give us only the time counter
    earlyData : Array(ThreadLoadModel) = get_load_data
    sleep 1.seconds
    latestData : Array(ThreadLoadModel) = get_load_data

    cores_deltas = get_deltas(earlyData: earlyData, latestData: latestData)
    usage = get_threads_usage(cores_deltas: cores_deltas)

    usage
  end

  def get_load_data : Array(ThreadLoadModel)
    path = "/proc/stat"

    data = [] of ThreadLoadModel

    File.each_line(filename: path) do |line|
      words = line.split
      if /cpu/.match(words[0])
        data << ThreadLoadModel.new(
          user: words[1].to_i64,
          nice: words[2].to_i64,
          system: words[3].to_i64,
          idle: words[4].to_i64,
          iowait: words[5].to_i64,
          irq: words[6].to_i64,
          softirq: words[7].to_i64,
          steal: words[8]?.try &.to_i64,
          guest: words[9]?.try &.to_i64,
          guest_nice: words[10]?.try &.to_i64
        )
      end
    end

    return data
  end

  def get_deltas(
    earlyData : Array(ThreadLoadModel),
    latestData : Array(ThreadLoadModel),
  ) : Array(ThreadLoadModel)
    zipped = earlyData.zip(latestData).map { |early, latest|
      get_each_load_values_deltas(a: early, b: latest)
    }

    zipped
  end

  def get_each_load_values_deltas(
    a : ThreadLoadModel, b : ThreadLoadModel,
  ) : ThreadLoadModel
    deltas = ThreadLoadModel.new(
      user: b.user - a.user,
      nice: b.nice - a.nice,
      system: b.system - a.system,
      idle: b.idle - a.idle,
      iowait: b.iowait - a.iowait,
      irq: b.irq - a.irq,
      softirq: b.softirq - a.softirq,
      steal: b.steal.try { |x| a.steal.try { |y| x - y } },
      guest: b.guest.try { |x| a.guest.try { |y| x - y } },
      guest_nice: b.guest_nice.try { |x| a.guest_nice.try { |y| x - y } }
    )

    deltas
  end

  def get_threads_usage(cores_deltas : Array(ThreadLoadModel)) : Array(CpuUsageModel)
    cores_load = cores_deltas.map do |deltas|
      total = deltas.user +
              deltas.nice +
              deltas.system +
              deltas.idle +
              deltas.iowait +
              deltas.irq +
              deltas.softirq +
              (deltas.steal || 0_i64) +
              (deltas.guest || 0_i64) +
              (deltas.guest_nice || 0_i64)

      idle = deltas.idle + deltas.iowait

      total_usage = (100 * (total - idle) / total).round(2)

      cpu_prc_usage = CpuUsageModel.new(
        total_pct: total_usage,
        user_pct: (100 * deltas.user / total).round(2),
        nice_pct: (100 * deltas.nice / total).round(2),
        system_pct: (100 * deltas.system / total).round(2),
        idle_pct: (100 * idle / total).round(2),
        iowait_pct: (100 * deltas.iowait / total).round(2),
        irq_pct: (100 * deltas.irq / total).round(2),
        softirq_pct: (100 * deltas.softirq / total).round(2),
        steal_pct: (100 * (deltas.steal || 0) / total).round(2),
        guest_pct: (100 * (deltas.guest || 0) / total).round(2),
        guest_nice_pct: (100 * (deltas.guest_nice || 0) / total).round(2)
      )
    end

    cores_load
  end
end
