class Broadcast < ActiveRecord::Base
    
    belongs_to :channel
    has_many :intentions
    
end
