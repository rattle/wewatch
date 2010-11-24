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

    if Friendship.count(:conditions => {:user_id => current_user.id}) > 0
      redirect_to root_path
    else
      @processing = true
      render :template => '/pages/processing'
    end
  end


  def destroy
    @current_user = nil
    session[:user_id] = nil
    redirect_to root_path
  end

end
