
require 'test_helper'

class IntentionsControllerTest < ActionController::TestCase

  context "when creating a successful watch intention via the API" do

    setup do
      post :create, :intention => {:broadcast_id => broadcasts(:motd).id, :comment => "test", :tweet => false}, :username => "frankieroberto", :format => :json
    end

    should respond_with :created
  end

  context "when creating an unsuccessful intention via the API" do

    setup do
      post :create, :intention => {:broadcast_id => nil, :comment => "test", :tweet => false}, :username => "frankieroberto", :format => :json
    end

    should respond_with :unprocessable_entity
  end

  context "when attempting to create an intention via the API without specifying a user" do

    setup do
      post :create, :intention => {:broadcast_id => broadcasts(:motd).id, :comment => "test", :tweet => false}, :format => :json
    end

    should respond_with :unauthorized
  end



  context "when deleting a watch intention successfully via API" do

    setup do
      delete :destroy, :id => intentions(:frankie_jurassic_park).id, :username => "frankieroberto", :format => :json
    end

    should respond_with :success

  end

  context "when deleting a watch intention unsuccessfully via API" do

    setup do
      delete :destroy, :id => intentions(:frankie_jurassic_park).id, :username => "frankieroberto2", :format => :json
    end

    should respond_with :bad_request

  end


end