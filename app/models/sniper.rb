class Sniper < ApplicationRecord
  STATUSES = [
    JOINING = 'joining'
  ].freeze

  after_commit :queue_join

  private

  def queue_join
    JoinAuctionJob.perform_later(id)
  end
end
