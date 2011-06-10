class AddSignificantToBroadcasts < ActiveRecord::Migration
  def self.up
    add_column :broadcasts, :significant, :boolean
  end

  def self.down
    remove_column :broadcasts, :significant
  end
end
