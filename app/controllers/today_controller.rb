class TodayController < ApplicationController


  def show
    start_time = DateTime.parse(@today.strftime("%Y-%m-%d") + "T19:00:00")
    end_time = DateTime.parse(@today.strftime("%Y-%m-%d") + "T23:59:59")

    @broadcasts = Broadcast.where(:start => start_time..end_time).includes(:channel).significant.order("start")
    
    respond_to do |format|
      format.xml
      format.json {
        render :json => @broadcasts
      }
    end
  end

end
