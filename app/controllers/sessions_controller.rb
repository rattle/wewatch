class SessionsController < ApplicationController

  def create
    auth = request.env['rack.auth']
    Rails.logger.info auth.inspect
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    self.current_user = @auth.user

    render :text => "Welcome, #{current_user.name}."
  end


  def destroy
      if signed_in?
          
          current_user.authorizations.find_each do |a|
              a.destroy
          end
          
          @current_user = nil
          session[:user_id] = nil
          redirect_to root_path
      end
  end

end
