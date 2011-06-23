class FollowingsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @friendship = Friendship.new(params[:friendship])

    raise Unauthorized if @friendship.user_id != current_user.id

    if @friendship.save
      redirect_to user_path(@friendship.friend.username)
    else

    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])

    raise Unauthorized if @friendship.user_id != current_user.id

    user = @friendship.friend

    @friendship.destroy
    redirect_to user_path(user.username)

  end

end
