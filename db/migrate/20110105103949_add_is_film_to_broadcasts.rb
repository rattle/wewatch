class AddIsFilmToBroadcasts < ActiveRecord::Migration
  def self.up
    add_column :broadcasts, :is_film, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :broadcasts, :is_film
  end
end
