# frozen_string_literal: true

module TestSupport
  class Auction
    attr_reader :item_id
    attr_reader :bidder_ids

    def initialize(item_id:)
      @item_id = item_id
      @bidder_ids = Set.new
    end
  end

end
