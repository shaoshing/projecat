require 'raspi_modules'

module CatFeeder
  autoload :EatingDetector,  "devices/eating_detector"

  class App
    def self.start
      EatingDetector.run
    end
  end
end
