Projecat::Admin.controllers :configurations do
  get :index do
    @title = "Configurations"
    @configurations = Configuration.all
    render 'configurations/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'configuration')
    @configuration = Configuration.new
    render 'configurations/new'
  end

  post :create do
    @configuration = Configuration.new(params[:configuration])
    if @configuration.save
      @title = pat(:create_title, :model => "configuration #{@configuration.id}")
      flash[:success] = pat(:create_success, :model => 'Configuration')
      params[:save_and_continue] ? redirect(url(:configurations, :index)) : redirect(url(:configurations, :edit, :id => @configuration.id))
    else
      @title = pat(:create_title, :model => 'configuration')
      flash.now[:error] = pat(:create_error, :model => 'configuration')
      render 'configurations/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "configuration #{params[:id]}")
    @configuration = Configuration.find(params[:id])
    if @configuration
      render 'configurations/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'configuration', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "configuration #{params[:id]}")
    @configuration = Configuration.find(params[:id])
    if @configuration
      if @configuration.update_attributes(params[:configuration])
        flash[:success] = pat(:update_success, :model => 'Configuration', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:configurations, :index)) :
          redirect(url(:configurations, :edit, :id => @configuration.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'configuration')
        render 'configurations/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'configuration', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Configurations"
    configuration = Configuration.find(params[:id])
    if configuration
      if configuration.destroy
        flash[:success] = pat(:delete_success, :model => 'Configuration', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'configuration')
      end
      redirect url(:configurations, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'configuration', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Configurations"
    unless params[:configuration_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'configuration')
      redirect(url(:configurations, :index))
    end
    ids = params[:configuration_ids].split(',').map(&:strip).map(&:to_i)
    configurations = Configuration.find(ids)
    
    if Configuration.destroy configurations
    
      flash[:success] = pat(:destroy_many_success, :model => 'Configurations', :ids => "#{ids.to_sentence}")
    end
    redirect url(:configurations, :index)
  end
end
