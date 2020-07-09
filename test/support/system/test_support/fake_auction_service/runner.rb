# frozen_string_literal: true

require_relative '../repeated_check'
require_relative '../auction'
require_relative '../bidder'

module TestSupport
  module FakeAuctionService
    class Runner
      include RepeatedCheck

      attr_reader :item_id

      def initialize(item_id, assertions)
        # minitest expects there to be an assertions variable in the class that
        # includes MiniTest::Assertions. Passing in the test class will allow us
        # to call all assertions and see the count of assertions in the console
        # output.
        @assertions = assertions
        @server = Server
        @server.clear
        @server.register_bidder_identity('abcd-123')
        @server_thread = start_server

        @item_id = item_id
      end

      def start_selling_item
        @server.auction_id = @item_id
      end

      def has_received_join_request_from_sniper
        repeat_check_with_timeout do
          @server.auction.bidders.include?(Bidder.new(identifier: 'abcd-123'))
        end
        @assertions.assert_includes @server.auction.bidders, Bidder.new(identifier: 'abcd-123')
      end

      def announce_closed
        @server.auction.bidders.each do |bidder|
          Faraday.post(bidder.callback_url, 'closed')
        end
      end

      def stop
        @server.quit!
        @server_thread.join
      end

      private

      def start_server
        Thread.new do
          @server.run!
        rescue StandardError => e
          $stderr << e.message
          $stderr << e.backtrace.join("\n")
        end
      end
    end
  end
end
