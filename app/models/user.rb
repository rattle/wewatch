class User < ActiveRecord::Base
  has_many :authorizations
  has_many :intentions
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user


  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end

  def retrieve_twitter_friends
    oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
    oauth.authorize_from_access(self.twitter.oauth_token, self.twitter.oauth_secret)
    client = Twitter::Base.new(oauth)

    begin
    Rails.logger.error "Starting"
    cursor = -1
    while (cursor != 0) do
      twitter_friends = client.friends(:cursor => cursor)
      cursor = twitter_friends[:next_cursor]
      Rails.logger.error "Cursor #{cursor}"
      twitter_friends.users.each do |friend|
        auth = { 'uid' => friend['id'], 'provider' => 'twitter',
                 'user_info' => { 'nickname' => friend['screen_name'], 'image' => friend['profile_image_url'], 'name' => friend['name']},
                 'credentials' => { 'token' => '', 'secret' => ''}}
        if @auth = Authorization.find_from_hash(auth)
          @auth.update_from_hash(auth)
        else
          @auth = Authorization.create_from_hash(auth)
        end
        self.friends << @auth.user unless Friendship.find(:first, :conditions => {:friend_id => @auth.user.id, :user_id => self.id})
      end
    end
    rescue Twitter::RateLimitExceeded
      return false
    end
  end

  def twitter
    self.authorizations.find(:first, :conditions => { :provider => 'twitter' })
  end

end
