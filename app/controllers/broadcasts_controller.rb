class BroadcastsController < ApplicationController

  def show
    @broadcast = Broadcast.find(params[:id])
  end

end
