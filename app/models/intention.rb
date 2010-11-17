class Intention < ActiveRecord::Base
  belongs_to :broadcast, :counter_cache => true
  belongs_to :user, :counter_cache => true
end
