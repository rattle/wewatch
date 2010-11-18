class IntentionsController < ApplicationController
    respond_to :html, :xml, :js
    before_filter :login_required

    def create
      @intention = Intention.new(:broadcast_id => params[:broadcast_id], :user => current_user)
      if @intention.save
        respond_with(@intention) do |format|
          format.html { redirect_to root_path }
        end
      else
        flash[:error] = 'Failed to add watch'
        redirect_to root_path 
      end
    end
    
    def destroy
       @intention = current_user.intentions.find(params[:id]) 
       if @intention.destroy
        respond_with(@intention) do |format|
          format.html { redirect_to root_path }
        end
       else
        flash[:error] = 'Failed to remove watch'
        redirect_to root_path 
       end
    end

    def tweet
      oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
      oauth.authorize_from_access(current_user.twitter.oauth_token, current_user.twitter.oauth_secret)
      client = Twitter::Base.new(oauth)
      #client.update(params[:share]) unless params[:share].blank?
      Rails.logger.info params[:share]
      redirect_to root_path
    end

end
