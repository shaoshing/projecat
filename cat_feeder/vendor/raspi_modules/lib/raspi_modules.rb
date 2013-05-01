require 'rubygems'

module RaspiModules
  autoload :SteppingMotor,  "raspi_modules/stepping_motor"
  autoload :Beeper,         "raspi_modules/beeper"
  autoload :SonicSensor,    "raspi_modules/sonic_sensor"

                  #  0   1   2   3   4   5   6   7  8  9  10 11 12  13 14  15  16
  RASPI_GPIO_PINS = [17, 18, 27, 22, 23, 24, 25, 4, 2, 3, 8, 7, 10, 9, 11, 14, 15]
end
