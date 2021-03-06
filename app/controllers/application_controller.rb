class ApplicationController < ActionController::Base

  module Exceptions
    class BadRequest < StandardError; end
    class Unauthorized < StandardError; end
  end

  include Exceptions

  helper :all

  protect_from_forgery

  before_filter :get_date

  def logged_in?
    current_user
  end

  def login_required
    redirect_to "/auth/twitter" unless logged_in?
  end


  def authenticate_admin!
    raise Unauthorized unless current_user.try(:admin?)
  end

  def authenticate_user!
    raise Unauthorized unless logged_in?
  end

  protected
  def get_date
    @today = params.has_key?(:date) ? Date.parse(params[:date]) : Date.today
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end



end
