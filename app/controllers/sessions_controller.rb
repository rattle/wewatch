class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    #Rails.logger.info auth.inspect
    if @auth = Authorization.find_from_hash(auth)
      @auth.update_from_hash(auth)
      self.current_user = @auth.user
      redirect_to root_path
    else

      @user = User.new(:username => auth['user_info']['nickname'], :name => auth['user_info']['name'])

      @user.authorizations.build(:provider => "twitter", :oauth_token => auth['credentials']['token'], :oauth_secret => auth['credentials']['secret'], :uid => auth['uid'])

#      @authorization = Authorization.new(:user => @user, :uid => auth['uid'], :provider => auth['provider'], :screen_name => auth['user_info']['nickname'], :avatar => auth['user_info']['image'], :oauth_token => auth['credentials']['token'], :oauth_secret => auth['credentials']['secret'])

      #@auth = Authorization.create_from_hash(auth, current_user)
      #self.current_user = @auth.user
      render "users/new"
    end

  end


  def destroy
    @current_user = nil
    session[:user_id] = nil
    redirect_to root_path
  end

end
