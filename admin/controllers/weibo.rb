Projecat::Admin.controllers :weibo do
  get :authorize do
    client = WeiboOAuth2::Client.new
    redirect client.authorize_url
  end

  get :authorized do
    client = WeiboOAuth2::Client.new
    access_token = client.auth_code.get_token(params[:code].to_s)
    user = client.users.show_by_uid(access_token.params["uid"].to_i)

    Configuration.weibo_name = user.screen_name
    Configuration.weibo_uid = access_token.params["uid"]
    Configuration.weibo_token = access_token.token
    Configuration.weibo_expired_at = access_token.expires_at

    Configuration.save

    redirect url(:configurations, :index)
  end
end
