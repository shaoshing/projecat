class CreateEatings < ActiveRecord::Migration
  def self.up
    create_table :eatings do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.timestamps
    end
  end

  def self.down
    drop_table :eatings
  end
end
