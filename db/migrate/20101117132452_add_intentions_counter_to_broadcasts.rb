class AddIntentionsCounterToBroadcasts < ActiveRecord::Migration
  def self.up
    add_column :broadcasts, :intentions_count, :integer
  end

  def self.down
    remove_column :broadcasts, :intentions_count
  end
end
