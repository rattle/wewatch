class TodayController < ApplicationController

  before_filter :get_user_from_request

  def show
    start_time = DateTime.parse(@today.strftime("%Y-%m-%d") + "T18:00:00 "  + Time.zone.now.strftime("%z"))
    end_time = DateTime.parse(@today.strftime("%Y-%m-%d") + "T23:59:59 " + Time.zone.now.strftime("%z"))

    @broadcasts = Broadcast.watchable.where(:start => start_time..end_time).includes(:channel)

    respond_to do |format|
      format.xml
      format.json {
        if @user
          @new_broadcasts = []
          @broadcasts.each do |broadcast|
            broadcast.watchers = broadcast.friends_intentions(@user)

            intention = broadcast.intentions.find_by_user_id(@user.id)
            if intention
              broadcast.watching = true
              broadcast.watching_id = intention.id
            else
              broadcast.watching = false
            end

#            broadcast.watchers = [User.last]
            @new_broadcasts << broadcast
          end
          render :json => @new_broadcasts
        else
          render :json => @broadcasts
        end
      }
    end
  end

  protected

  def get_user_from_request

    if params[:username]
      @user = User.find_by_username!(params[:username])
    end

  end

end
