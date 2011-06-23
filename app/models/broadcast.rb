require 'open-uri'

class Broadcast < ActiveRecord::Base

    belongs_to :channel
    has_many :intentions

    validates_presence_of :channel

    scope :significant, :conditions => {:significant => true}
    scope :non_repeat, :conditions => {:is_repeat => false}
    scope :by_most_popular, :order => "intentions_count DESC"

    has_attached_file :image, :styles => { :thumb => "156x86", :medium => "362x204" }, :path => "public/system/:attachment/:id/:style.jpg", :url => "/system/:attachment/:id/:style.jpg"

    before_save :set_significance, :set_duration

    attr_accessor :watching, :watching_id

    def self.watchable
      significant.non_repeat.order(:start)
    end

    def as_json(options={})
      json = {:id => id, :title => title, :start => start, :end => self.end, :duration => duration, :description => synopsis, :watchers => intentions_count.to_i, :channel => {:name => channel.name}, :link => link, :film => is_film}
      json[:subtitle] = subtitle unless subtitle.blank?
      json[:image] = {:thumb => image.url(:thumb)} if image_file_name
      w_json = []

      if watchers
        watchers.each do |watcher|
          i = {:username => watcher.user.username}
#          i[:comment] = watcher.comment unless watcher.comment.blank?
          w_json << i
        end
      end

      if !watching.nil?
        json[:watching] = watching
      end

      if !watching_id.nil?
        json[:watching_id] = watching_id
      end

      json[:friends_watching] = w_json unless w_json.size == 0
      json
    end

  def watchers
    @watchers
  end

  def watchers=(users)
    @watchers = users
  end

  def friends(user)
     in_sql = user.friends_with_intentions.collect { |f| f.id }.join(',')
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

   private

   def set_duration
     self.duration = self.end - self.start
   end

   def set_significance

     insignificant_titles = [/.*News.*/, /.*Weather.*/, /.*EastEnders.*/, /The National Lottery.*/, /World Championship Snooker.*/, /Look North.*/, "Hollyoaks", "4thought.tv", "The One Show", "Eggheads"]

     self.significant = true
     insignificant_titles.each do |insignificant_title|
       if title.match(insignificant_title)
         self.significant = false
       end
     end

   end

end
