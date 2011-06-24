class BroadcastsController < ApplicationController

  before_filter :authenticate_admin!, :except => :show
  before_filter :find_broadcast, :only => [:edit, :update, :destroy]

  respond_to :html, :json


  def show
    @broadcast = Broadcast.find(params[:id], :include => :intentions)
    respond_with @broadcast, :include => [:intentions]
  end

  def new
    @broadcast = Broadcast.new
    @channels = Channel.all
  end

  def edit
    @channels = Channel.all
  end

  def create
    @broadcast = Broadcast.new(params[:broadcast])

    if @broadcast.save
      redirect_to broadcast_path(@broadcast)
    else
      @channels = Channel.all
      render :new
    end

  end

  def destroy
    @broadcast.destroy
    redirect_to root_path
  end

  def update

    if @broadcast.update_attributes(params[:broadcast])
      redirect_to broadcast_path(@broadcast)
    else
      @channels = Channel.all
      render :edit
    end
  end

  protected

    def find_broadcast
      @broadcast = Broadcast.find(params[:id])
    end

end
