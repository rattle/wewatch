class ChannelsController < ApplicationController

  before_filter :authenticate_admin!
  before_filter :find_channel, :only => [:show, :edit, :update, :destroy]

  def index
    @channels = Channel.all
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(params[:channel])

    if @channel.save
      redirect_to channel_path(@channel)
    else
      render :new
    end
  end

  def update

    if @channel.update_attributes(params[:channel])
      redirect_to channel_path(@channel)
    else
      render :edit
    end

  end

  def destroy
    @channel.destroy

    redirect_to channels_path
  end

  protected

    def find_channel
      @channel = Channel.find(params[:id])
    end


end
