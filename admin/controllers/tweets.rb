Projecat::Admin.controllers :tweets do
  get :index do
    @title = "Tweets"
    @tweets = Tweet.all
    render 'tweets/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'tweet')
    @tweet = Tweet.new
    render 'tweets/new'
  end

  post :create do
    @tweet = Tweet.new(params[:tweet])
    if @tweet.save
      @title = pat(:create_title, :model => "tweet #{@tweet.id}")
      flash[:success] = pat(:create_success, :model => 'Tweet')
      params[:save_and_continue] ? redirect(url(:tweets, :index)) : redirect(url(:tweets, :edit, :id => @tweet.id))
    else
      @title = pat(:create_title, :model => 'tweet')
      flash.now[:error] = pat(:create_error, :model => 'tweet')
      render 'tweets/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "tweet #{params[:id]}")
    @tweet = Tweet.find(params[:id])
    if @tweet
      render 'tweets/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'tweet', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "tweet #{params[:id]}")
    @tweet = Tweet.find(params[:id])
    if @tweet
      if @tweet.update_attributes(params[:tweet])
        flash[:success] = pat(:update_success, :model => 'Tweet', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:tweets, :index)) :
          redirect(url(:tweets, :edit, :id => @tweet.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'tweet')
        render 'tweets/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'tweet', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Tweets"
    tweet = Tweet.find(params[:id])
    if tweet
      if tweet.destroy
        flash[:success] = pat(:delete_success, :model => 'Tweet', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'tweet')
      end
      redirect url(:tweets, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'tweet', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Tweets"
    unless params[:tweet_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'tweet')
      redirect(url(:tweets, :index))
    end
    ids = params[:tweet_ids].split(',').map(&:strip).map(&:to_i)
    tweets = Tweet.find(ids)
    
    if Tweet.destroy tweets
    
      flash[:success] = pat(:destroy_many_success, :model => 'Tweets', :ids => "#{ids.to_sentence}")
    end
    redirect url(:tweets, :index)
  end
end
