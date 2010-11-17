class IntentionsController < ApplicationController

#    before_filter :login_required

    def create
      
      @intention = Intention.new(params[:intention]) 
      @intention.user = current_user
      
      if @intention.save
         redirect_to root_path 
      end
        
    end
    
    def destroy
       
       @intention = Intention.find(params[:id]) 
       
       if @intention.user = current_user
          @intention.destroy
          redirect_to root_path
        else    
           raise "Security VIOLOATION!" 
        end           
        
    end


end
