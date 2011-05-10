class AddTweetToIntentions < ActiveRecord::Migration
  def self.up
    add_column :intentions, :tweet, :boolean, :default => false
  end

  def self.down
    remove_column :intentions, :tweet
  end
end
