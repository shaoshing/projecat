module CatFeeder
  class FeedingDevice
    PIN_NUM = 7
    DURATION = 0.25

    def self.drop
      @pin ||= PiPiper::Pin.new(:pin => RASPI_GPIO_PINS[PIN_NUM], :direction => :out)

      @pin.on
      sleep DURATION
      @pin.off
    end
  end
end
