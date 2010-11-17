class AddFieldsToUser < ActiveRecord::Migration
  def self.up

    add_column :users, :nickname, :string, :default => nil
    add_column :users, :image, :string, :default => nil
    add_column :users, :oauth_token, :string, :default => nil
    add_column :users, :oauth_secret, :string, :default => nil
    
  end

  def self.down

    remove_column :users, :nickname
    remove_column :users, :image
    remove_column :users, :oauth_token
    remove_column :users, :oauth_secret

  end
end
