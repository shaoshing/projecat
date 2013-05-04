require "devices/base"

module CatFeeder
  autoload :EatingDetectDevice,  "devices/eating_detect_device"
  autoload :FeedingDevice,  "devices/feeding_device"
  autoload :Camera,  "devices/camera"
  autoload :Beeper,  "devices/beeper"

  class App
    def self.run
      reset

      # Feeder Device
      Thread.new do
        loop do
          sleep_seconds = 30
          now = Time.now
          now_int = now.strftime("%H%M").to_i
          @feeding_time_ints.each do |time_int|
            if now_int == time_int
              Beeper.beep(5)
              FeedingDevice.drop
              Feeding.create!
              # Sleep in a longer time to avoid trigger the same feeding schedule twice
              sleep_seconds = 70
              break
            end
          end

          sleep sleep_seconds
        end
      end

      # Eating Detect Device
      Thread.new do
        loop do
          if EatingDetectDevice.eating?
            started_at, ended_at = EatingDetectDevice.last_eating_times
            ::Eating.create!(started_at: started_at, ended_at: ended_at)
          end
          sleep 10
        end
      end
    end

    # TODO: mutex
    def self.reset
      @feeding_time_ints = ::Configuration.feeding_times.map &:to_i
    end
  end # App
end
