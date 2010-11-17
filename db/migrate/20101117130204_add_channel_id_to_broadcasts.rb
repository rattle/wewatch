class AddChannelIdToBroadcasts < ActiveRecord::Migration
  def self.up
    add_column :broadcasts, :channel_id, :integer
  end

  def self.down
    remove_column :broadcasts, :channel_id
  end
end
