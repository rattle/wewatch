class DaysController < ApplicationController

  def show
    @date = Date.parse(params[:year] + "-" + params[:month] + "-" + params[:day])

    start_time = DateTime.parse(@date.strftime("%Y-%m-%d") + "T18:00:00 "  + Time.zone.now.strftime("%z"))
    end_time = DateTime.parse(@date.strftime("%Y-%m-%d") + "T23:59:59 " + Time.zone.now.strftime("%z"))

    @broadcasts = Broadcast.where(:start => start_time..end_time).includes(:channel).significant.order("start")

  end

end
