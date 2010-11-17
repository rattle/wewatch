class Friend < ActiveRecord::Base

  belongs_to :users

  validates_uniqueness_of :user_id, :scope => :uid, :allow_nil => true

end
