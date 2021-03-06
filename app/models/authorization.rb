class Authorization < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil)
    user ||= User.create_from_hash!(hash)
    Authorization.create(:user => user, :uid => hash['uid'], :provider => hash['provider'], :screen_name => hash['user_info']['nickname'], :avatar => hash['user_info']['image'], :oauth_token => hash['credentials']['token'], :oauth_secret => hash['credentials']['secret'])
  end

  def update_from_hash(hash)
    h = { :uid => hash['uid'], :provider => hash['provider'], :screen_name => hash['user_info']['nickname'], :avatar => hash['user_info']['image'] }
    # if we're updating an existing user from a friend, then we don't want to blank the oauth details
    h.merge!(:oauth_token => hash['credentials']['token'], :oauth_secret => hash['credentials']['secret']) unless hash['credentials']['token'].blank?
    update_attributes(h)
  end

end
