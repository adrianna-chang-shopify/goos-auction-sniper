class Sniper < ApplicationRecord
  STATUSES = [
    JOINING = 'joining',
    LOST = 'lost',
  ].freeze

  after_commit :queue_join

  def close_auction
    self.status = LOST
  end

  private

  def queue_join
    JoinAuctionJob.perform_later(id)
  end
end
