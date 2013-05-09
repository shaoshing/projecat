# encoding: UTF-8

class Weibo
  def self.post content
    statuses.update(content)
  end

  def self.status
    client = WeiboOAuth2::Client.new
    client.get_token_from_hash({:access_token => Configuration.weibo_token, :expires_at => Configuration.weibo_expired_at})
    client.statuses
  end

  def self.post_feeding
    post("花酱，主人喊你吃饭了！")
  end

  EATING_POSTS = [
    "花酱她又来吃饭了...",
    "花酱她来吃饭了",
    "花酱她来吃饭了，感觉又变胖了",
  ]
  def self.post_eating
    post(EATING_POSTS[rand(EATING_POSTS.length)])
  end
end
