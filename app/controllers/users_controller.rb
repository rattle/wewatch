class UsersController < ApplicationController

  def show
    @user = User.find_by_username!(params[:id])
  end

  def update
    @user = User.find_by_username!(params[:id])
    raise "Not Authorized" unless @user == current_user

    if @user.update_attributes(params[:user])
      redirect_to root_path
    else
      render "settings/show"
    end

  end


  def create
    @user = User.new(params[:user])

    if @user.save
      self.current_user = @user
      redirect_to root_path
    else
      render :new
    end
  end

end
