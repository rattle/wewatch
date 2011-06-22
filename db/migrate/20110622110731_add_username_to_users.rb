class AddUsernameToUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end
  class Authorization < ActiveRecord::Base
  end

  def self.up
    add_column :users, :username, :string

    # Copy screen_name from Twitter authorizations to users
    User.find_each do |user|
      auth = Authorization.find_by_user_id_and_provider(user.id, "twitter")
      if auth
        user.update_attribute(:username, auth.screen_name)
      end
    end

  end

  def self.down
    remove_column :users, :username
  end
end
