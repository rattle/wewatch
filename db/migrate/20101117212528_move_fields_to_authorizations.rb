class MoveFieldsToAuthorizations < ActiveRecord::Migration
  def self.up

    add_column :authorizations, :screen_name, :string
    add_column :authorizations, :avatar, :string
    add_column :authorizations, :oauth_token, :string
    add_column :authorizations, :oauth_secret, :string

    Authorization.find(:all).each do |authorization|
      authorization.screen_name = authorization.user.nickname
      authorization.avatar = authorization.user.image
      authorization.oauth_token = authorization.user.oauth_token
      authorization.oauth_secret = authorization.user.oauth_secret
      authorization.save
    end

    remove_column :users, :nickname
    remove_column :users, :image
    remove_column :users, :oauth_token
    remove_column :users, :oauth_secret
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
