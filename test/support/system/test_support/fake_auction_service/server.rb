# frozen_string_literal: true

require 'sinatra/base'
require 'set'

module TestSupport
  module FakeAuctionService
    class Server < Sinatra::Base
      def self.clear
        @bidder_ids = nil
        @auction = nil
      end

      def self.register_bidder_identity(identity)
        bidder_ids << identity
      end

      def self.bidder_ids
        @bidder_ids ||= Set.new
      end

      def self.auction_id=(item_id)
        @auction = Auction.new(item_id: item_id)
      end

      def self.auction
        @auction
      end

      before do
        bidder_id = request.env["HTTP_X_BIDDER_IDENTITY"]
        halt 403 unless self.class.bidder_ids.include?(bidder_id)
      end

      post '/auction/:id/join' do
        if params['id'] == self.class.auction.item_id
          bidder_id = request.env["HTTP_X_BIDDER_IDENTITY"]
          self.class.auction.bidder_ids << bidder_id
          'joined'
        else
          not_found do
            'unknown item'
          end
        end
      end
    end
  end
end
