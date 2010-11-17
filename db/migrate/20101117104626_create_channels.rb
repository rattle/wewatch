class CreateChannels < ActiveRecord::Migration
  def self.up
    create_table :channels do |t|
      t.string :name
      t.string :xml_url

      t.timestamps
    end
  end

  def self.down
    drop_table :channels
  end
end
