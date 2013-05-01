require 'raspi_modules'

module CatFeeder
  autoload :EatingMonitor,  "devices/eating_monitor"

  class App
    def self.start
      EatingMonitor.run
    end
  end
end
