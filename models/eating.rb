class Eating < ActiveRecord::Base
  def minutes
    (ended_at - started_at) / 60
  end
end
