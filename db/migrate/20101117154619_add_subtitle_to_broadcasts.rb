class AddSubtitleToBroadcasts < ActiveRecord::Migration
  def self.up
    add_column :broadcasts, :subtitle, :string
  end

  def self.down
    remove_column :broadcasts, :subtitle
  end
end
