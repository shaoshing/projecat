require 'rubygems'
require 'pi_piper'

PINS_MAP = [17, 18, 27, 22, 23, 24, 25, 4]
MAX_COUNT = 360
RIGHT_PINS = [0, 1, 2, 3].map{|pin| PiPiper::Pin.new(:pin => PINS_MAP[pin], :direction => :out)}
LEFT_PINS = RIGHT_PINS.reverse
SECONDS = 60

current_count = 0
started_at = Time.now
beeper = PiPiper::Pin.new(:pin => 4, :direction => :out)

Thread.new do
  loop do
    # sleep 1
    # beeper.on && sleep(0.05) && beeper.off
  end
end

while true
  pins = (current_count/MAX_COUNT%2) == 0 ? RIGHT_PINS : LEFT_PINS
  pins.each_with_index do |pin, index|
    index == current_count%pins.length ? pin.on : pin.off
  end

  current_count += 1
  sleep 0.01

  break if (Time.now - started_at) > SECONDS
end

beeper.off
RIGHT_PINS.each &:off
