class Broadcast < ActiveRecord::Base
    
    belongs_to :channel
    has_many :intentions

    scope :significant, :conditions => ['is_repeat = ? AND title NOT LIKE "%News%" AND title NOT LIKE "%Weather%"', false]
    scope :by_most_popular, :order => "intentions_count DESC"
    

   def friends(user)
     in_sql = user.friends.collect { |f| f.id }.join(',')
     return [] if in_sql.blank?
     User.find(:all, :include => :intentions, :conditions => ["intentions.user_id IN (#{in_sql}) AND intentions.broadcast_id = ?", self.id])
   end

end
