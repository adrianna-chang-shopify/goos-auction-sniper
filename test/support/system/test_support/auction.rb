# frozen_string_literal: true

module TestSupport
  class Auction
    attr_reader :item_id
    attr_reader :bidders

    def initialize(item_id:)
      @item_id = item_id
      @bidders = Set.new
    end
  end
end
