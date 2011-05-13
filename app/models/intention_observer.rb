class IntentionObserver < ActiveRecord::Observer
  observe :intention
  
  def after_create(intention)

    if intention.tweet?
      
      message = ""
      message += intention.comment.to_s + " - " unless intention.comment.blank?      
      message += intention.broadcast.title + " " + Rails.application.routes.url_helpers.broadcast_path(intention.broadcast, :host => "wewatch.co.uk", :only_path => false)
      
      begin
      oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
      oauth.authorize_from_access(intention.user.twitter.oauth_token, intention.user.twitter.oauth_secret)
      client = Twitter::Base.new(oauth)
      client.update(message)
      
      rescue 
        intention.logger.error "Failed to post update to Twitter"
      end
      
    end  

  end

end
