class Intention < ActiveRecord::Base
  belongs_to :broadcast, :counter_cache => true
  belongs_to :user, :counter_cache => true
  
  validates_presence_of :broadcast_id, :user_id
  validates_uniqueness_of :user_id, :scope => :broadcast_id
  
  
  
  
end
