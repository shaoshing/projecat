module CatFeeder
  class EatingDetectDevice
    PIN_NUM = 6
    INITIAL_TIME_OUT = 5 # INITIAL_TIME_OUT * DURATION (seconds)
    TIME_OUT = 20 # TIME_OUT * DURATION (seconds)
    DURATION = 0.5

    def self.eating?
      @started_at = nil
      @ended_at = nil
      @pin ||= PiPiper::Pin.new(:pin => RASPI_GPIO_PINS[PIN_NUM], :direction => :in)

      @pin.read
      if @pin.off?
        time_out = true
        INITIAL_TIME_OUT.times do
          @pin.read
          if @pin.on?
            time_out = false
            break
          end
          sleep DURATION
        end

        return false if time_out
      end

      @started_at = Time.now
      off_count = 0
      loop do
        sleep DURATION
        @pin.read
        if @pin.on?
          off_count = 0
          next
        else
          off_count += 1
          break if off_count >= TIME_OUT
        end
      end
      @ended_at = Time.now - TIME_OUT*DURATION

      return true
    end

    def self.last_eating_times
      return @started_at, @ended_at
    end
  end # EatingMonitor
end # CatFeeder
