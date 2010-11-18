class RedoFriendsModel < ActiveRecord::Migration
  def self.up
    drop_table :friends
   
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end

  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
