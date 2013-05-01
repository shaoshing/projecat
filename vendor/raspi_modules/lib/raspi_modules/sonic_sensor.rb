require 'pi_piper'

module RaspiModules
  class SonicSensor
    def initialize(trigger, echo)
      @trigger_pin = PiPiper::Pin.new(:pin => RASPI_GPIO_PINS[trigger], :direction => :out)
      @echo_pin = PiPiper::Pin.new(:pin => RASPI_GPIO_PINS[echo], :direction => :in)
    end

    TIME_OUT = 200 # milliseconds
    SOUND_SPEED = 340*100/1000.0/1000.0 # sound speed in cm/nanosecond
    def detect
      @trigger.off && @trigger.on && sleep(0.0001) && @trigger.off

      start = Time.now
      count = 0
      until @echo.on?
        count += 1
        sleep(0.00001)

        if count*0.00001 > TIME_OUT/1000.0
          return 0  # return 0 to indicate time out
        end
      end
      ended = Time.now

      diff_ns = ended.to_f*1000*1000 - start.to_f*1000*1000
      distance = (SOUND_SPEED*diff_ns).to_i/2

      distance
    end
  end
end
