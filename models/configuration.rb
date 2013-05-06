class Configuration < ActiveRecord::Base

  FEEDING_SCHEDULES = {
    name: :feeding_schedule,
    default: "0000, 0400, 0800, 1200, 1600, 2000",
    desc: "Multiple times are separated by [,]. Example: 0000, 0800, 1200",
  }

  FEEDING_QUANTITY = {
    name: :feeding_quantity,
    default: "300",
    desc: "In milliseconds. Example: 500, 800"
  }

  KEYS = local_constants.map{|c| Configuration.const_get(c)}.select{ |constant|
    constant.is_a?(Hash) && constant[:name].present?
  }

  class <<self
    KEYS.each do |key|
      define_method(key[:name]) do
        @cached_configs ||= load_configs
        @cached_configs[key[:name]] || key[:default]
      end

      define_method("#{key[:name]}=") do |value|
        @update_configs ||= {}
        @update_configs[key[:name]] = value
      end
    end

    def save
      if @update_configs
        @update_configs.each do |key, val|
          config = Configuration.find_by_key(key) || Configuration.new(key: key)
          config.value = val
          config.save!
        end
        @update_configs = nil
        @cached_configs = nil
      end

      CatFeeder::App.reset
    end

    def reset
      KEYS.each{|key| self.send("#{key[:name]}=", key[:default])}
      save
    end

    def load_configs
      keys = KEYS.map{|config| config[:name]}

      configs = {}
      Configuration.where(key: keys).each do |config|
        configs[config.key.to_sym] = config.value
      end

      configs
    end
  end # <<self
end
