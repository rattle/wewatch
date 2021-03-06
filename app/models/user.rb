class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :intentions, :dependent => :destroy
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  validates_presence_of :username
  validates_uniqueness_of :username

  accepts_nested_attributes_for :authorizations

  attr_readonly :username
  attr_protected :admin

  def following?(user)
    self.friendships.find_by_friend_id(user.id)
  end

  def recent_intentions
    intentions.joins(:broadcast).includes(:broadcast => :channel).order("broadcasts.start DESC").limit(10)
  end

  def friends_with_intentions
    friends.where("intentions_count > 0")
  end

  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'], :username => hash['user_info']['nickname'])
  end

  def retrieve_twitter_friends

    Twitter.configure do |config|
      config.consumer_key = CONSUMER_KEY
      config.consumer_secret = CONSUMER_SECRET
      config.oauth_token = self.twitter.oauth_token
      config.oauth_token_secret = self.twitter.oauth_secret
    end

    friend_ids = []

    begin
      cursor = -1
      while (cursor != 0) do
        twitter_friends = Twitter.friends({:cursor => cursor})
        cursor = twitter_friends.next_cursor
        twitter_friends.users.each do |friend|
          friend_ids << friend.id
        end
      end
    end

    puts friend_ids
#        auth = { 'uid' => friend['id'], 'provider' => 'twitter',
#                 'user_info' => { 'nickname' => friend['screen_name'], 'image' => friend['profile_image_url'], 'name' => friend['name']},
 #                'credentials' => { 'token' => '', 'secret' => ''}}
        #if @auth = Authorization.find_from_hash(auth)
        #  @auth.update_from_hash(auth)
        #else
        #  @auth = Authorization.create_from_hash(auth)
        #end
        #self.friends << @auth.user unless Friendship.find(:first, :conditions => {:friend_id => @auth.user.id, :user_id => self.id})
#      end
#    end
#    rescue Twitter::RateLimitExceeded
#      return false
#    end
#    true
  end

  def twitter
    self.authorizations.find(:first, :conditions => { :provider => 'twitter' })
  end

end
