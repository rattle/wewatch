class User < ActiveRecord::Base
  has_many :authorizations

  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'], :nickname => hash['user_info']['nickname'], :image => hash['user_info']['image'], :oauth_token => hash['credentials']['token'], :oauth_secret => hash['credentials']['secret'] )
  end

end
