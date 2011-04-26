class AddImageUrlToBroadcasts < ActiveRecord::Migration
  def self.up
    add_column :broadcasts, :image_url, :string
  end

  def self.down
    remove_column :broadcasts, :image_url
  end
end
