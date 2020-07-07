require 'minitest/autorun'
require 'capybara/dsl'
require 'capybara/minitest'

require_relative "test/support/system/test_support/application_runner.rb"
require_relative "test/support/system/test_support/fake_auction_service/runner.rb"
require_relative "test/support/system/test_support/fake_auction_service/server.rb"

class TestThreads < Minitest::Test
  include Capybara::DSL

  def setup
    @auction = TestSupport::FakeAuctionService::Runner.new("item-54321", self)
    @application_runner = TestSupport::ApplicationRunner.new
  end

  def teardown
    @auction.stop
    @application_runner.stop
  end

  def test_something
    sleep 5
    puts "------- Thread: running a test -------"
    assert true
  end
end