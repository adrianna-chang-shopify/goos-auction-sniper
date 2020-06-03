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
    end

    def start_bidding_in(auction)
      create_sniper auction.item_id  # similar to starting the application with an auction_id
      shows_auction_status("StatusForJoining")
    end

    def stop
      # noop rails system test takes care of starting and stopping the rails
      # server
    end

    private

    def shows_auction_status(status)
      assertions.assert_equal status, find("css-lookup-for-status").text
    end

    def create_sniper(item_id)
      visit 'path/to/create'
      fill_in 'form_id', with: item_id
      click_button('button-identifier')
    end
  end
end
