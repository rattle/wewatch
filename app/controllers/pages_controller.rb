class PagesController < ApplicationController

  def index
      @title = "Home"
      
      today = Date.today
      
      start_time = DateTime.parse(today.strftime("%Y-%m-%d") + "T19:00:00")
      end_time = DateTime.parse(today.strftime("%Y-%m-%d") + "T19:59:59")
      
      @broadcasts_7pm = Broadcast.all(:conditions => {:start => start_time..end_time, :is_repeat => false}, :order => "intentions_count DESC", :include => :channel)

      start_time += 1.hour
      end_time += 1.hour

      @broadcasts_8pm = Broadcast.all(:conditions => {:start => start_time..end_time, :is_repeat => false}, :order => "intentions_count DESC", :include => :channel)

      start_time += 1.hour
      end_time += 1.hour

      @broadcasts_9pm = Broadcast.all(:conditions => {:start => start_time..end_time, :is_repeat => false}, :order => "intentions_count DESC", :include => :channel)

      start_time += 1.hour
      end_time += 1.hour

      @broadcasts_10pm = Broadcast.all(:conditions => {:start => start_time..end_time, :is_repeat => false}, :order => "intentions_count DESC", :include => :channel)

      start_time += 1.hour
      end_time += 1.hour

      @broadcasts_11pm = Broadcast.all(:conditions => {:start => start_time..end_time, :is_repeat => false}, :order => "intentions_count DESC", :include => :channel)

      
  end

  def about
      @title = "About"
  end

end
