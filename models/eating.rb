class Eating < ActiveRecord::Base
  def duration_in_words
    amount_seconds = (ended_at - started_at).to_i
    seconds = amount_seconds % 60
    minutes = amount_seconds / 60

    "%02i:%02i" % [minutes, seconds]
  end
end
