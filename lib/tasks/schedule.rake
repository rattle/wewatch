require 'hpricot'
require 'open-uri'


namespace "schedules" do

  desc "Get all of today's programmes"
  task :today => [:environment, "schedules:channel4", "schedules:bbc"] do
    
  end

  desc "Get Channel 4 programmes"
  task :channel4 => :environment do
    
    day = Date.today
    
    url = "http://www.channel4.com/tv-listings/daily/" + day.strftime("%Y/%m/%d")
    
    file = open(url)
    doc = Hpricot(file)
    
    channel_lists = doc.search("td.channelSlots")
    
    channel_lists.each do |channel_list|
      
      channel_ref = channel_list[:id].gsub("SlotList_", "")
      
      if channel_ref == "C4"
        channel = Channel.find_by_name("Channel 4")
      elsif channel_ref == "M4"
        channel = Channel.find_by_name("More4")        
      elsif channel_ref == "F4"
        channel = Channel.find_by_name("Film4")        
      elsif channel_ref == "E4"
        channel = Channel.find_by_name("E4")        
      end
      
      if channel
        puts channel.name        
        broadcast_listings = channel_list.search("/div")
        
        broadcast_listings.each do |broadcast_listing|

          h3 = broadcast_listing.at('h3')
          
          starttime = DateTime.parse(day.to_s + " " + h3.at('span').inner_html + " " + Time.now.strftime("%z"))
          
          running_time = h3.at('span')[:title].gsub("Running time (mins): ", "")
          endtime = starttime + running_time.to_i.minutes
          
          
          if h3.at('a')
            link = h3.at('a')[:href]
            title = h3.at('a').inner_html
            
            if link.chars.first == "/"
              link = "http://www.channel4.com" + link
            end
            
          else
            link = nil
            title = h3.children.select{|e| e.text?}.join.strip
          end

          if broadcast_listing.at('span[@title=Repeat]')
            is_repeat = true
          else
            is_repeat = false
          end
          
          if broadcast_listing.at('a[@href=/programmes/tags/film]')
            is_film = true
          else
            is_film = false
          end

          synopsis = broadcast_listing.at('p.synopsis').inner_html.strip

          b = Broadcast.find_by_channel_id_and_title(channel.id, title)
            
          unless b && b.start == starttime && b.end == endtime
            b = Broadcast.new
          end
          
          b.channel = channel
          b.start = starttime
          b.end =  endtime
          b.is_repeat = is_repeat
          b.duration =  running_time.to_i * 60
          b.synopsis = synopsis
          b.link = link
          b.title = title
          b.is_film = is_film
          b.save

        end

      end
      
    end
    
  end

  desc "Get BBC programmes schedule"
  task :bbc => :environment do
    
    puts "Getting today's schedule..."
    
    day = Date.today
    
    Channel.find_each(:conditions => "xml_url IS NOT NULL") do |channel|

      url = channel.xml_url
      
      begin

        file = open(url)
        doc = Hpricot.XML( file )
        broadcasts = doc.search("//schedule/day/broadcasts/broadcast")
      
        if broadcasts.size > 0
          
          broadcasts.each do |broadcast|
            
            starttime = DateTime.parse(broadcast.at('start').inner_html)
            endtime = DateTime.parse(broadcast.at('end').inner_html)
            link = BBC_URL + "/programmes/" + broadcast.at('programme/pid').inner_html

            b = Broadcast.find_by_channel_id_and_link(channel.id, link)
              
            unless b && b.start == starttime && b.end == endtime
              b = Broadcast.new
            end
            
            b.channel = channel
            b.start = starttime
            b.end =  endtime
            b.is_repeat = broadcast['is_repeat']
            b.duration =  broadcast.at('duration').inner_html
            b.synopsis = broadcast.at('programme/short_synopsis').inner_html      
            b.link = link
            
            b.title = broadcast.at('programme/display_titles/title').inner_html
            b.subtitle = broadcast.at('programme/display_titles/subtitle').inner_html if broadcast.at('programme/display_titles/subtitle')
            b.save
            
            b.image_url = "http://www.bbc.co.uk/iplayer/images/episode/" + broadcast.at('programme/pid').inner_html + "_512_288.jpg"
            
            b.fetch_programme_info
            b.save_image
              
          end
        end
      
      end
    
    end
  
    

  end


end