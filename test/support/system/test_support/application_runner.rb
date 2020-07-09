# frozen_string_literal: true

require 'capybara/dsl'
require 'capybara/minitest'

module TestSupport
  class ApplicationRunner
    include MiniTest::Assertions
    include Capybara::DSL

    attr_reader :assertions

    def initialize(assertions)
      # minitest expects there to be an assertions variable in the
      # class that includes MiniTest::Assertions. Passing in the
      # test class will allow us to call all assertions and see the
      # count of assertions in the console output.
      @assertions = assertions
      start_server
    end

    def start_bidding_in(auction)
      create_sniper auction.item_id # similar to starting the application with an auction_id
      shows_auction_status(Sniper::JOINING)
    end

    def show_sniper_has_lost_auction
      visit '/snipers'
      shows_auction_status(Sniper::LOST)
    end

    def stop
      # noop rails system test takes care of starting and stopping the rails
      # server
    end

    private

    def start_server
      Capybara.app = Rack::Builder.new do
        run Rails.application
      end
      Capybara.server = :puma
      Capybara.always_include_port = true
    end

    def shows_auction_status(status)
      assertions.assert_equal status, find('#bidding-status').text
    end

    def create_sniper(item_id)
      visit 'snipers/new'
      fill_in 'new-sniper--item-id', with: item_id
      click_button('join-auction')
    end
  end
end
