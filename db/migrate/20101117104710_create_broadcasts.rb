class CreateBroadcasts < ActiveRecord::Migration
  def self.up
    create_table :broadcasts do |t|
      t.datetime :start
      t.datetime :end
      t.string :link
      t.string :synopsis

      t.timestamps
    end
  end

  def self.down
    drop_table :broadcasts
  end
end
