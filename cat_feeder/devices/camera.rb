require 'pi_piper'

module CatFeeder
  class Camera
    PIN_NUMS = [0, 1, 2, 3]
    DEFAULT_COUNT = 20

    def self.take(path=nil)
      path ||= "/tmp/#{Time.now.to_i}.jpg"
      photo_paths << path
      `fswebcam -r 1280x960 -d /dev/video0 #{path}`
      path
    end

    def self.photo_paths
      @photo_paths ||= []
    end

    def self.rotate(options = {direction: :left, count: DEFAULT_COUNT})
      @pins ||= PIN_NUMS.map{|pin_num| PiPiper::Pin.new(:pin => RASPI_GPIO_PINS[pin_num], :direction => :out) }

      pins = options[:direction] == :left ? @pins : @pins.reverse
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
