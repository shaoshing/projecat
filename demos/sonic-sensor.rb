require 'rubygems'
require 'pi_piper'
include PiPiper

beeper = PiPiper::Pin.new(:pin => 4, :direction => :out)
light = PiPiper::Pin.new(:pin => 25, :direction => :out)
input = PiPiper::Pin.new(:pin => 24, :direction => :out)

high_pulse_begin_at = nil
after :pin => 24, :goes => :high do
  high_pulse_begin_at = Time.now.to_f*1000*1000
end

after :pin => 24, :goes => :low do
  if high_pulse_begin_at
    duration = Time.now.to_f*1000*1000 - high_pulse_begin_at
    high_pulse_begin_at = nil
    puts "#{duration.to_i} us = #{(340.0*100/1000/1000*duration).to_i/2} cm"
    light.on && sleep(0.1) && light.off
  else
    puts "No high pulse"
    beeper.on && sleep(0.05) && beeper.off
  end
end

def detect
  pin4 = PiPiper::Pin.new(:pin => 23, :direction => :out)
  pin4.off && pin4.on && sleep(0.1) && pin4.off
end

loop do
  detect
  sleep(0.1)
end
