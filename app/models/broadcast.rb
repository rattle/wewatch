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
     intention = Intention.find(:first, :conditions => { :broadcast_id => self.id, :user_id => user.id }
     return users if intention.nil?
     user.friends.each do |friend|
       f = User.find(:first, :include => [:authorizations], :conditions => ['authorizations.uid = ? AND authorizations.provider = ?', friend.uid, 'twitter'])
       next if f.nil?
       users << f if f.intentions.count(:conditions => ['user_id = ? AND broadcast_id = ?', f.id, self.id])
     end
     users
   end

end
