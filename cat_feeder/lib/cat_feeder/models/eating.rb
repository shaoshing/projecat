module CatFeeder
  class Eating
    include DataMapper::Resource

    property :id,         Serial
    property :started_at, DateTime
    property :ended_at,   DateTime
  end
end
