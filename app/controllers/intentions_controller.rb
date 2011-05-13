class IntentionsController < ApplicationController
    respond_to :html, :xml, :js
    before_filter :login_required


    def new
      @broadcast = Broadcast.find(params[:broadcast_id])
      @intention = Intention.new(:broadcast_id => @broadcast.id, :user => current_user)
    end


    def create
      @intention = Intention.new(params[:intention])
      @intention.user = current_user
      
      if @intention.save
        respond_with(@intention, @intention.broadcast) do |format|
          format.html { redirect_to root_path }
        end
      else
        flash[:error] = 'Failed to add watch'
        redirect_to root_path 
      end
    end
    
    def destroy
       @intention = current_user.intentions.find(params[:id]) 
       @broadcast = @intention.broadcast
       if @intention.destroy
        respond_with(@intention) do |format|
          format.html { redirect_to root_path }
        end
       else
        flash[:error] = 'Failed to remove watch'
        redirect_to root_path 
       end
    end

    def watchers
      @broadcast = Broadcast.find_by_id(params[:broadcast_id])
      @total = @broadcast.intentions.count
      @friends = @broadcast.friends(current_user)
      respond_with(@friends, @broadcast, @total) do |format|
        format.html { redirect_to root_path }
      end
    end

end
