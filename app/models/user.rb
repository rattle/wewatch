class User < ActiveRecord::Base
  has_many :authorizations
  has_many :friends

  def self.create_from_hash!(hash)
    
    Rails.logger.info "name : #{hash['user_info']['name']}"
    Rails.logger.info "nickname : #{hash['user_info']['nickname']}"
    Rails.logger.info "image : #{hash['user_info']['image']}"
    Rails.logger.info "oauth_token : #{hash['credentials']['token']}"
    Rails.logger.info "oauth_secret : #{hash['credentials']['secret']}"
    create(:name => hash['user_info']['name'], :nickname => hash['user_info']['nickname'], :image => hash['user_info']['image'], :oauth_token => hash['credentials']['token'], :oauth_secret => hash['credentials']['secret'] )
  end

  def retrieve_friends

    oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
    oauth.authorize_from_access(self.oauth_token, self.oauth_secret)
    Rails.logger.info oauth.inspect
    client = Twitter::Base.new(oauth)
    Rails.logger.info client.inspect

    client.friends.each do |friend|
      Friend.new(:user_id => self.id, :uid => friend['id'], :name => friend['name'], :screen_name => friend['screen_name']).save
      Rails.logger.info friend.inspect
    end
  end

end
