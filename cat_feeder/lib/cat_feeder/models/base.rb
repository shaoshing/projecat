require 'data_mapper'
require 'cat_feeder/models/eating'
require 'cat_feeder/models/feeding'

DataMapper.setup(:default, "sqlite:///#{File.expand_path('../../../../db/data.db', __FILE__)}")
DataMapper.finalize
DataMapper.auto_upgrade!
