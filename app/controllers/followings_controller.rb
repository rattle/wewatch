class FollowingsController < ApplicationController

  before_filter :authenticate_user!

  def create

    @user = User.find_by_username!(params[:user_id])
    raise Unauthorized if @user != current_user

    @friendship = Friendship.new(params[:friendship])
    @friendship.user = @user

    if @friendship.save
      redirect_to user_path(@friendship.friend.username)
    else

    end
  end

  def index
    @user = User.find_by_username!(params[:user_id])
  end

  def destroy
    @friendship = Friendship.find(params[:id])

    raise Unauthorized if @friendship.user_id != current_user.id

    user = @friendship.friend

    @friendship.destroy
    redirect_to user_path(user.username)

  end

end
