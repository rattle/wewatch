class IntentionsController < ApplicationController

    before_filter :login_required

    def create
      @intention = Intention.new(:broadcast_id => params[:broadcast_id], :user => current_user)
      unless @intention.save
        flash[:error] = 'Failed to add watch'
      end
      redirect_to root_path 
    end
    
    def destroy
       @intention = current_user.intentions.find(params[:id]) 
       @intention.destroy
       redirect_to root_path
    end


end
