class AddFieldsToBroadcasts < ActiveRecord::Migration
  def self.up
    add_column :broadcasts, :is_repeat, :boolean
    add_column :broadcasts, :duration, :integer
    add_column :broadcasts, :title, :string
  end

  def self.down
    remove_column :broadcasts, :title
    remove_column :broadcasts, :duration
    remove_column :broadcasts, :is_repeat
  end
end
