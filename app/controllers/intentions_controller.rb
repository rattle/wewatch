class IntentionsController < ApplicationController
    respond_to :html, :xml, :js, :json
    before_filter :login_required, :except => [:create, :destroy]

    skip_before_filter :verify_authenticity_token

    rescue_from BadRequest, :with => :bad_request
    rescue_from Unauthorized, :with => :unauthorised

    def new
      @broadcast = Broadcast.find(params[:broadcast_id])
      @intention = Intention.new(:broadcast_id => @broadcast.id, :user => current_user)
    end


    def create
      @intention = Intention.new(params[:intention])

      if current_user
        @intention.user = current_user
      elsif params[:username]

        auth = Authorization.find_by_screen_name(params[:username])
        if auth
          @intention.user = auth.user
        else
          raise BadRequest, "User not recognised" and return
        end

      else
        raise Unauthorized, "Unauthorised request" and return
      end

      if @intention.save
        respond_with(@intention) do |format|
          format.html { redirect_to root_path }
        end
      else
        respond_with(@intention) do |format|
          format.html { redirect_to root_path }
        end
      end
    end

    def destroy
      if current_user
        @intention = current_user.intentions.find(params[:id])
      elsif params[:username]
        auth = Authorization.find_by_screen_name(params[:username])

        raise BadRequest, "User not found" if auth.nil?

        @intention = auth.user.intentions.find(params[:id])
      end
       @broadcast = @intention.broadcast
       if @intention.destroy
        respond_with(@intention) do |format|
          format.html { redirect_to root_path }
        end
       else
        flash[:error] = 'Failed to remove watch'
        redirect_to root_path
       end
    end

    def watchers
      @broadcast = Broadcast.find_by_id(params[:broadcast_id])
      @total = @broadcast.intentions.count
      @friends = @broadcast.friends(current_user)
      respond_with(@friends, @broadcast, @total) do |format|
        format.html { redirect_to root_path }
      end
    end

    private

    def unauthorised
      render :text => "Not authorised", :status => :unauthorized
    end

    def bad_request
      render :text => "Bad request", :status => :bad_request
    end

end
