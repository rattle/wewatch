class HomepageController < ApplicationController

  def show
    
    start_time = DateTime.parse(@today.strftime("%Y-%m-%d") + "T18:00:00 "  + Time.zone.now.strftime("%z"))
    end_time = DateTime.parse(@today.strftime("%Y-%m-%d") + "T23:59:59 " + Time.zone.now.strftime("%z"))

    @broadcasts = Broadcast.where(:start => start_time..end_time).includes(:channel).significant.order("start")
    
  end

end