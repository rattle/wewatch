require 'test_helper'

class DaysControllerTest < ActionController::TestCase

  context "when viewing a particular day" do

    setup { get :show, :year => "2011", :month => "01", :day => "01"}

    should respond_with :success
    should assign_to :broadcasts

  end


end
