class IntentionsController < ApplicationController

#    before_filter :login_required

    def create
      
      @intention = Intention.new(params[:intention]) 
      @intention.user = current_user
      
      if @intention.save
         redirect_to root_path 
      end
        
    end


end
