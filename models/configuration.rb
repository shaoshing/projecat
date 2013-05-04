class Configuration < ActiveRecord::Base

  # Find all feedings

  # Time Format
  #   hhmm => 0212, 1222
  def self.feeding_times
    ["0400", "0800", "1200", "1600", "2000", "0000"]
  end

end
