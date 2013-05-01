require 'pi_piper'

module RaspiModules
  class SteppingMotor
    PIN_NUMBERS = 4
    def initialize(pin_numbers)
      raise "Pin number must be #{PIN_NUMBERS}" unless pins.size == PIN_NUMBERS
      @pins = pins.map{|pin| PiPiper::Pin.new(:pin => RASPI_GPIO_PINS[pin], :direction => :out)}
    end

    DEFAULT_DURATION = 20 # seconds
    def rotate(option = {direction: :left, duration: DEFAULT_DURATION})
      pins = option[:direction] == :left ? @pins : @pins.reverse
      duration = options[:duration] || DEFAULT_DURATION

      high_pin_index = 0
      started_at = Time.now
      loop do
        pins.each_with_index do |pin, index|
          index == high_pin_index%pins.length ? pin.on : pin.off
        end

        high_pin_index += 1
        break if (Time.now - started_at) > duration

        sleep 0.01
      end

      pins.each &:off
    end
  end
end
