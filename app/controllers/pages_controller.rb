class PagesController < ApplicationController

  def index
      @title = "Home"

      @broadcasts = []
      @broadcast_titles = []
      
      today = Date.today
      start_time = DateTime.parse(today.strftime("%Y-%m-%d") + "T19:00:00")
      end_time = DateTime.parse(today.strftime("%Y-%m-%d") + "T19:59:59")

      (7..11).each do |hour|
        @broadcast_titles << "#{hour}PM"
        @broadcasts << Broadcast.all(:conditions => ['start BETWEEN ? AND ? AND is_repeat = ? AND title NOT LIKE "%BBC%News%"', start_time, end_time, false], :order => "intentions_count DESC", :include => :channel)
        start_time += 1.hour
        end_time += 1.hour
      end

  end

  def about
      @title = "About"
  end

end
