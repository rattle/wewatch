require 'hpricot'
require 'open-uri'


namespace "schedules" do

  desc "Get today's schedule"
  task :today do
    
    puts "Getting today's schedule..."
    
    day = Date.today
    
    Channel.find_each do |channel|

      # Construct url to XML of schedule
      url = BBC_URL + "/" + channel.slug + "/programmes/schedules/"
      url += channel.region + "/" if service.region
      url += date.year.to_s + "/" + date.strftime("%m") + "/" + date.strftime("%d") + ".xml"

      puts url
      
    end
  
    

  end


end