require 'hpricot'
require 'open-uri'


namespace "schedules" do

  desc "Get today's schedule"
  task :today => :environment do
    
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
            
            starttime = DateTime.parse(broadcast.at('start').inner_html)
            endtime = DateTime.parse(broadcast.at('end').inner_html)

            b = Broadcast.find_by_channel_id_and_start_and_end(channel.id, starttime, endtime)

            unless b
              b = Broadcast.new
              b.channel = channel
              b.start = starttime
              b.end =  endtime
              b.is_repeat = broadcast['is_repeat']
              b.duration =  broadcast.at('duration').inner_html
              b.synopsis = broadcast.at('programme/short_synopsis').inner_html      
              b.link = BBC_URL + "/programmes/" + broadcast.at('programme/pid').inner_html
              
              b.title = broadcast.at('programme/display_titles/title').inner_html
              b.subtitle = broadcast.at('programme/display_titles/subtitle').inner_html if broadcast.at('programme/display_titles/subtitle')
  
              b.save
              
              b.fetch_programme_info
              
            end
          end
        end
      
    end
    
end
  
    

  end


end