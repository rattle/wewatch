module UsersHelper

  def username_path(user, options = {})
    url_for(options.merge(:controller => :users, :action => :show, :id => user.username))
  end

  def username_url(user, options = {})
    username_path(user, options.merge!(:only_path => false))
  end


end
