class Weibo
  def self.post content
    statuses.update(content)
  end

  def self.status
    client = WeiboOAuth2::Client.new
    client.get_token_from_hash({:access_token => Configuration.weibo_token, :expires_at => Configuration.weibo_expired_at})
    client.statuses
  end
end
