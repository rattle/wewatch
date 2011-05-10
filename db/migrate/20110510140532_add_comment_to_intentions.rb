class AddCommentToIntentions < ActiveRecord::Migration
  def self.up
    add_column :intentions, :comment, :string
  end

  def self.down
    remove_column :intentions, :comment
  end
end
