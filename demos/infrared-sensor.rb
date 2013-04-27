require 'rubygems'
require 'pi_piper'
include PiPiper

beeper = PiPiper::Pin.new(:pin => 4, :direction => :out)
watch :pin => 25 do
  puts "Pin changed from #{last_value} to #{value}"
  beeper.on && sleep(0.05) && beeper.off if value == 1
end
