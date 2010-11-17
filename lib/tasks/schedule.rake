require 'hpricot'
require 'open-uri'


namespace "schedules" do

  desc "Get today's schedule"
  task :today do
    
    puts "Getting today's schedule..."
    
    day = Date.today
    
    Channel.find_each do |channel|

      url = channel.xml_url
      
      begin

        file = open(url)
        doc = Hpricot.XML( file )
        broadcasts = doc.search("//schedule/day/broadcasts/broadcast")
      
        if broadcasts.size > 0
          
          broadcasts.each do |broadcast|

            b = Broadcast.find(:first, :conditions => {:channel_id => channel.id, :start => broadcast.at('start').inner_html, :end => broadcast.at('end').inner_html})

            unless b
              b = Broadcast.new
              b.channel = channel
              b.start = broadcast.at('start').inner_html
              b.end =  broadcast.at('end').inner_html
              b.is_repeat = broadcast['is_repeat']
              b.duration =  broadcast.at('duration').inner_html
              b.synopsis = broadcast.at('programme/short_synopsis').inner_html      
              b.link = BBC_URL + "/programmes/" + broadcast.at('programme/pid').inner_html
              
              b.title = broadcast.at('programme/display_titles/title').inner_html
              b.bsubtitle = broadcast.at('programme/display_titles/subtitle').inner_html if broadcast.at('programme/display_titles/subtitle')
  
              b.save
              
            end
          end
        end
      
    end
    
end
  
    

  end


end