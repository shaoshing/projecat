Projecat::Admin.controllers :configurations do
  get :index do
    @feeding_configs = [Configuration::FEEDING_SCHEDULES, Configuration::FEEDING_QUANTITY]
    @weibo_configs = [Configuration::WEIBO_UID, Configuration::WEIBO_TOKEN,
      Configuration::WEIBO_EXPIRED_AT, Configuration::WEIBO_NAME]

    @title = "Configurations"
    render 'configurations/index'
  end

  put :save do
    params[:configuration].each do |key, value|
      Configuration.send("#{key}=", value)
    end
    Configuration.save
    flash[:success] = "Configurations has been updated!"
    redirect url(:configurations, :index)
  end

  get :reset do
    Configuration.reset
    flash[:success] = "Configurations have been reset to default"
    redirect url(:configurations, :index)
  end
end
