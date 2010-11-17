class AddIntentionsCounterToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :intentions_count, :integer
  end

  def self.down
    remove_column :users, :intentions_count
  end
end
