class User < ActiveRecord::Base
  has_many :authorizations
  has_many :intentions
  has_many :friends

  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end

  def retrieve_twitter_friends
    oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
    oauth.authorize_from_access(self.twitter.oauth_token, self.twitter.oauth_secret)
    client = Twitter::Base.new(oauth)

    client.friends.each do |friend|
      Friend.new(:user_id => self.id, :uid => friend['id'], :name => friend['name'], :screen_name => friend['screen_name']).save
    end
  end

  def twitter
    self.authorizations.find(:first, :conditions => { :provider => 'twitter' })
  end

end
