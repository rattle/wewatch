require 'open-uri'

class Broadcast < ActiveRecord::Base
    
    belongs_to :channel
    has_many :intentions
    
    validates_presence_of :channel

    scope :significant, :conditions => ['is_repeat = ? AND title NOT LIKE "%News%" AND title NOT LIKE "%Weather%" AND title NOT LIKE "%EastEnders%" AND title NOT LIKE "The National Lottery%" AND title NOT LIKE "World Championship Snooker%" AND title NOT LIKE "Look North%"', false]
    scope :by_most_popular, :order => "intentions_count DESC"
    
    has_attached_file :image, :styles => { :thumb => "156x86", :medium => "303x170" }, :path => "public/system/:attachment/:id/:style.jpg", :url => "/system/:attachment/:id/:style.jpg"
    

    def as_json(options={})
      json = {:id => id, :title => title, :start => start, :end => self.end, :duration => duration, :description => synopsis, :watchers => intentions.count.to_i, :channel => {:name => channel.name}}
      json[:subtitle] = subtitle unless subtitle.blank?
      json[:image] = {:thumb => image.url(:thumb)} if image_file_name
      w_json = []

      if watchers
        watchers.each do |watcher|
          i = {:username => watcher.user.twitter.screen_name}
          i[:comment] = watcher.comment unless watcher.comment.blank?
          w_json << i
        end
      end
      json[:friends_watching] = w_json
      json
    end   
    
  def watchers
    @watchers
  end  

  def watchers=(users)
    @watchers = users
  end
  
  def friends(user)
     in_sql = user.friends.collect { |f| f.id }.join(',')    
     return [] if in_sql.blank?
     User.find(:all, :include => :intentions, :conditions => ["intentions.user_id IN (#{in_sql}) AND intentions.broadcast_id = ?", self.id])
     
  end

   def friends_intentions(user)
     in_sql = user.friends.collect { |f| f.id }.join(',')
     return [] if in_sql.blank?
     intentions.all(:conditions => ["user_id IN (#{in_sql})"])
   end
   
   def fetch_programme_info
     
#     unless self.is_film
      
       response = HTTParty.get(self.link + ".json")
       if response
         categories = response["programme"]["categories"]
       
         categories.each do |category|
           if category["type"] && category["type"] == "format"
             if category["key"] == "films"
               self.is_film = true
             end
           end 
         end         

         self.save
       end
       
#     end    
     
     return self
   end
   
   def save_image
     if image_url
       file = open(image_url)
       self.image = file
       save
     end
   end

end
