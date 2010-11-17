class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.integer :user_id
      t.integer :uid
      t.string :name
      t.string :screen_name

      t.timestamps
    end
  end

  def self.down
    drop_table :friends
  end
end
