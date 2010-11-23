class IntentionsController < ApplicationController
    respond_to :html, :xml, :js
    before_filter :login_required

    def create
      @broadcast = Broadcast.find_by_id(params[:broadcast_id])
      @intention = Intention.new(:broadcast_id => @broadcast.id, :user => current_user)
      if @intention.save
        respond_with(@intention, @broadcast) do |format|
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

    def tweet
      begin
      oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
      oauth.authorize_from_access(current_user.twitter.oauth_token, current_user.twitter.oauth_secret)
      client = Twitter::Base.new(oauth)
      #client.update(params[:share]) unless params[:share].blank?
      Rails.logger.info params[:share]
      respond_with() do |format|
        format.html { redirect_to root_path }
      end
      rescue 
        flash[:error] = "Failed to add your update to twitter."
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
