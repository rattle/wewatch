class Broadcast < ActiveRecord::Base
    
    belongs_to :channel
    has_many :intentions

    scope :significant, :conditions => ['is_repeat = ? AND title NOT LIKE "%News%" AND title NOT LIKE "%Weather%" AND title NOT LIKE "%EastEnders%" AND title NOT LIKE "The National Lottery%" AND title NOT LIKE "World Championship Snooker%" AND title NOT LIKE "Look North%"', false]
    scope :by_most_popular, :order => "intentions_count DESC"
    

    def as_json(options={})
      json = {:id => id, :title => title, :start => start, :end => self.end, :duration => duration, :description => synopsis, :watchers => intentions.count.to_i, :channel => {:name => channel.name}}
      json[:subtitle] = subtitle unless subtitle.blank?
      json
    end   


   def friends(user)
     in_sql = user.friends.collect { |f| f.id }.join(',')
     return [] if in_sql.blank?
     User.find(:all, :include => :intentions, :conditions => ["intentions.user_id IN (#{in_sql}) AND intentions.broadcast_id = ?", self.id])
   end
   
   def fetch_programme_info
     
     unless self.is_film
      
       response = HTTParty.get(self.link + ".json")
       if response
         categories = response["programme"]["categories"]
       
         categories.each do |category|
           if category["type"] && category["type"] == "format"
             if category["key"] == "films"
               self.is_film = true
               self.save
             end
           end 
         end
       end
       
     end
     
     return self
   end

end
