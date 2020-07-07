# frozen_string_literal: true

module TestSupport
  module FakeAuctionService
    class Runner
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

      def stop
        puts "Stopping server"
        wait_for_server_to_start

        @server.quit!
        puts "------- Stopping auction service server thread -------"
        @server_thread.join
      end

      private

      def start_server
        Thread.new do
          begin
            puts "------- Thread: running auction service server -------"
            @server.run!
          rescue StandardError => e
            $stderr << e.message
            $stderr << e.backtrace.join("\n")
          end
        end
      end

      def wait_for_server_to_start
        while !@server.running_server? do
          sleep 1
        end
      end
    end
  end
end
