class Intention < ActiveRecord::Base
  belongs_to :broadcast, :counter_cache => true
  belongs_to :user, :counter_cache => true
  
  validates_presence_of :broadcast, :user_id
  validates_uniqueness_of :user_id, :scope => :broadcast_id
  
  validates_length_of :comment, :maximum => 80
  
  
end
