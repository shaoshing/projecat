require 'pi_piper'

module RaspiModules
  class Beeper
    def initialize(pin_number)
      @pin = PiPiper::Pin.new(:pin => RASPI_GPIO_PINS[pin_number], :direction => :out)
    end

    def beep(duration)
      @pin.on
      sleep duration
      @pin.off
    end
  end
end
