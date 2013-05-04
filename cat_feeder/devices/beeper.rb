module CatFeeder
  class Beeper
    PIN_NUM = 5
    ON_DURATION = 0.1
    OFF_DURATION = 0.5

    def self.beep(beep_num = 1)
      @pin ||= PiPiper::Pin.new(:pin => RASPI_GPIO_PINS[PIN_NUM], :direction => :out)

      beep_num.times do
        @pin.on
        sleep ON_DURATION
        @pin.off
        sleep OFF_DURATION
      end
    end
  end
end
