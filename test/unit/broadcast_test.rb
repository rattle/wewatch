require 'test_helper'

class BroadcastTest < ActiveSupport::TestCase

  should belong_to :channel
  should have_many :intentions

  should validate_presence_of :channel

  context "when saving a regular broadcast" do

    setup do
      @broadcast = Broadcast.create(:channel => channels(:bbcone), :title => "A programme")
      @broadcast.reload
    end

    should "set the signficance as true" do
      assert_equal true, @broadcast.significant
    end

  end

  context "when saving an EastEnders broadcast" do

    setup do
      @broadcast = Broadcast.create(:channel => channels(:bbcone), :title => "EastEnders")
      @broadcast.reload
    end

    should "set the signficance as false" do
      assert_equal false, @broadcast.significant
    end

  end

  context "when saving a news broadcast" do

    setup { @broadcast = Broadcast.create(:channel => channels(:bbcone), :title => "Channel 4 News")}

    should "set the significance as false" do
      assert_equal false, @broadcast.significant
    end

  end

end
