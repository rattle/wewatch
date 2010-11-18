class SessionsController < ApplicationController

  def create
    auth = request.env['rack.auth']
    #Rails.logger.info auth.inspect
    if @auth = Authorization.find_from_hash(auth)
      @auth.update_from_hash(auth)
    else
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in
    self.current_user = @auth.user
    current_user.retrieve_twitter_friends

    redirect_to root_path
  end


  def destroy
    @current_user = nil
    session[:user_id] = nil
    redirect_to root_path
  end

end
