class Broadcast < ActiveRecord::Base
    
    belongs_to :channel
    has_many :intentions

    scope :significant, :conditions => {:is_repeat => false}
    scope :by_most_popular, :order => "intentions_count DESC"
    

    
end
