require 'pi_piper'

module CatFeeder
  class Camera
    PIN_NUMS = [0, 1, 2, 3]
    DEFAULT_COUNT = 20 #

    def self.take
    end

    def self.rotate(option = {direction: :left, count: DEFAULT_COUNT})
      @pins = PIN_NUMS.map{|pin_num| PiPiper::Pin.new(:pin => RASPI_GPIO_PINS[pin_num], :direction => :out) }

      pins = option[:direction] == :left ? @pins : @pins.reverse
      count_down = options[:count] || DEFAULT_DURATION
      high_pin_index = 0
      loop do
        pins.each_with_index do |pin, index|
          index == high_pin_index%pins.length ? pin.on : pin.off
        end

        high_pin_index += 1
        break if (count_down -= 1) == 0

        sleep 0.01
      end

      pins.each &:off
    end
  end
end
