class Broadcast < ActiveRecord::Base
    
    belongs_to :channel
    has_many :intentions

    scope :significant, :conditions => {:is_repeat => false}
    scope :by_most_popular, :order => "intentions_count DESC"
    
    #def friends(user)
    #  User.find(:all, :include => [:authorizations, :intentions, :friends], :conditions => ['intentions.broadcast_id = ?', self.id])
    #end

   def friends(user)
     users = []
     user.friends.each do |friend|
       users << friend if friend.intentions.count(:conditions => ['user_id = ? AND broadcast_id = ?', friend.id, self.id]) > 0
     end
     users
   end

end
