class PagesController < ApplicationController

  before_filter :login_required, :only => [:processing]

  def index
      @title = "Home"

      @broadcasts = []
      @broadcast_titles = []
      
      start_time = DateTime.parse(@today.strftime("%Y-%m-%d") + "T18:00:00")
      end_time = DateTime.parse(@today.strftime("%Y-%m-%d") + "T19:59:59")

      (6..11).each do |hour|
        @broadcast_titles << "#{hour}PM"
        @broadcasts  << Broadcast.where(:start => start_time..end_time).significant.by_most_popular
        start_time += 1.hour
        end_time += 1.hour
      end

  end

  def processing
    flash[:error] = 'Failed to retrieve your friends' unless current_user.retrieve_twitter_friends
    redirect_to root_path
  end

  def about
      @title = "About"
  end

end
