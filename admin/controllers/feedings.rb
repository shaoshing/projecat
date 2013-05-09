Projecat::Admin.controllers :feedings do
  get :index do
    @title = "Feedings"
    @feedings = Feeding.order("created_at DESC")
    render 'feedings/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'feeding')
    @feeding = Feeding.new
    render 'feedings/new'
  end

  post :create do
    @feeding = Feeding.new(params[:feeding])
    if @feeding.save
      @title = pat(:create_title, :model => "feeding #{@feeding.id}")
      flash[:success] = pat(:create_success, :model => 'Feeding')
      params[:save_and_continue] ? redirect(url(:feedings, :index)) : redirect(url(:feedings, :edit, :id => @feeding.id))
    else
      @title = pat(:create_title, :model => 'feeding')
      flash.now[:error] = pat(:create_error, :model => 'feeding')
      render 'feedings/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "feeding #{params[:id]}")
    @feeding = Feeding.find(params[:id])
    if @feeding
      render 'feedings/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'feeding', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "feeding #{params[:id]}")
    @feeding = Feeding.find(params[:id])
    if @feeding
      if @feeding.update_attributes(params[:feeding])
        flash[:success] = pat(:update_success, :model => 'Feeding', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:feedings, :index)) :
          redirect(url(:feedings, :edit, :id => @feeding.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'feeding')
        render 'feedings/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'feeding', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Feedings"
    feeding = Feeding.find(params[:id])
    if feeding
      if feeding.destroy
        flash[:success] = pat(:delete_success, :model => 'Feeding', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'feeding')
      end
      redirect url(:feedings, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'feeding', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Feedings"
    unless params[:feeding_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'feeding')
      redirect(url(:feedings, :index))
    end
    ids = params[:feeding_ids].split(',').map(&:strip).map(&:to_i)
    feedings = Feeding.find(ids)

    if Feeding.destroy feedings
      flash[:success] = pat(:destroy_many_success, :model => 'Feedings', :ids => "#{ids.to_sentence}")
    end
    redirect url(:feedings, :index)
  end

  get :feed do
    CatFeeder::App.feed
    flash[:success] = "Num num num num, delicious!"
    redirect url(:feedings, :index)
  end
end
