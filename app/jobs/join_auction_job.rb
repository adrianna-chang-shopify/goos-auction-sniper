# frozen_string_literal: true

class JoinAuctionJob < ActiveJob::Base
  queue_as :default

  def perform(sniper_id)
    sniper = Sniper.find(sniper_id)
    JoinAuction.new(sniper).call
  end
end
