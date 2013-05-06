require 'pi_piper'

module CatFeeder
  class FeedingDevice
    PIN_NUM = 7
    DEFAULT_QUANTITY = 0.5  # in seconds

    def self.drop(quantity = DEFAULT_QUANTITY)
      @pin ||= PiPiper::Pin.new(:pin => RASPI_GPIO_PINS[PIN_NUM], :direction => :out)

      @pin.on
      sleep quantity
      @pin.off
    end
  end
end
