class BroadcastsController < ApplicationController

  before_filter :authenticate_admin!, :except => :show

  def show
    @broadcast = Broadcast.find(params[:id])
  end

  def edit
    @broadcast = Broadcast.find(params[:id])
    @channels = Channel.all
  end

  def update
    @broadcast = Broadcast.find(params[:id])
    if @broadcast.update_attributes(params[:broadcast])
      redirect_to broadcast_path(@broadcast)
    else
      @channels = Channel.all
      render :edit
    end
  end

end
