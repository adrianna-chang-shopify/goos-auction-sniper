# require 'application_system_test_case'

# class WalkingSkeletonsTest < ApplicationSystemTestCase
#   setup do
#     @auction = TestSupport::FakeAuctionService::Runner.new('item-54321', self)
#     @application = TestSupport::ApplicationRunner.new(self)
#   end

#   teardown do
#     auction.stop
#     application.stop
#   end

#   test 'sniper joins auction until it closes' do
#     auction.start_selling_item # step 1
#     application.start_bidding_in(auction) # step 2
#     auction.has_received_join_request_from_sniper # step 3
#     auction.announce_closed # step 4
#     application.show_sniper_has_lost_auction # step 5
#   end

#   private

#   attr_reader :auction, :application
# end

require 'test_helper'

require_relative '../support/system/test_support/application_runner.rb'
require_relative '../support/system/test_support/fake_auction_service/runner.rb'
require_relative '../support/system/test_support/fake_auction_service/server.rb'

class WalkingSkeletonsTest < ActiveSupport::TestCase
  setup do
    @auction = TestSupport::FakeAuctionService::Runner.new('item-54321', self)
    @application = TestSupport::ApplicationRunner.new(self)
  end

  teardown do
    auction.stop
    application.stop
  end

  test 'sniper joins auction until it closes' do
    auction.start_selling_item # step 1
    application.start_bidding_in(auction) # step 2
    auction.has_received_join_request_from_sniper # step 3
    auction.announce_closed # step 4
    application.show_sniper_has_lost_auction # step 5
  end

  private

  attr_reader :auction, :application
end
