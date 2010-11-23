class Broadcast < ActiveRecord::Base
    
    belongs_to :channel
    has_many :intentions

    scope :significant, :conditions => ['is_repeat = ? AND title NOT LIKE "%News%" AND title NOT LIKE "%Weather%"', false]
    scope :by_most_popular, :order => "intentions_count DESC"
    
   def friends(user)
     users = []
     in_sql = user.friends.collect { |f| f.id }.join(',')
     users << friend if self.intentions.count(:conditions => ['user_id IN (?) AND broadcast_id = ?', in_sql, self.id])>0
     users
   end

end
