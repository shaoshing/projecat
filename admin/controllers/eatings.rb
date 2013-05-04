Projecat::Admin.controllers :eatings do
  get :index do
    @title = "Eatings"
    @eatings = Eating.order("created_at DESC")
    render 'eatings/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'eating')
    @eating = Eating.new
    render 'eatings/new'
  end

  post :create do
    @eating = Eating.new(params[:eating])
    if @eating.save
      @title = pat(:create_title, :model => "eating #{@eating.id}")
      flash[:success] = pat(:create_success, :model => 'Eating')
      params[:save_and_continue] ? redirect(url(:eatings, :index)) : redirect(url(:eatings, :edit, :id => @eating.id))
    else
      @title = pat(:create_title, :model => 'eating')
      flash.now[:error] = pat(:create_error, :model => 'eating')
      render 'eatings/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "eating #{params[:id]}")
    @eating = Eating.find(params[:id])
    if @eating
      render 'eatings/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'eating', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "eating #{params[:id]}")
    @eating = Eating.find(params[:id])
    if @eating
      if @eating.update_attributes(params[:eating])
        flash[:success] = pat(:update_success, :model => 'Eating', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:eatings, :index)) :
          redirect(url(:eatings, :edit, :id => @eating.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'eating')
        render 'eatings/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'eating', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Eatings"
    eating = Eating.find(params[:id])
    if eating
      if eating.destroy
        flash[:success] = pat(:delete_success, :model => 'Eating', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'eating')
      end
      redirect url(:eatings, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'eating', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Eatings"
    unless params[:eating_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'eating')
      redirect(url(:eatings, :index))
    end
    ids = params[:eating_ids].split(',').map(&:strip).map(&:to_i)
    eatings = Eating.find(ids)

    if Eating.destroy eatings

      flash[:success] = pat(:destroy_many_success, :model => 'Eatings', :ids => "#{ids.to_sentence}")
    end
    redirect url(:eatings, :index)
  end
end
