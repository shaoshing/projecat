require 'bundler/setup'
require 'raspi_modules'
require 'cat_feeder/models/base'

module CatFeeder
  autoload :EatingMonitor,  "cat_feeder/devices/eating_monitor"

  class App
    def self.start
      EatingMonitor.run
      Process.wait
    end
  end
end
