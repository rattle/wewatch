class CreateIntentions < ActiveRecord::Migration
  def self.up
    create_table :intentions do |t|
      t.integer :user_id
      t.references :broadcast

      t.timestamps
    end
  end

  def self.down
    drop_table :intentions
  end
end
