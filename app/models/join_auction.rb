
class JoinAuction
  include Rails.application.routes.url_helpers

  attr_reader :sniper

  def initialize(sniper)
    @sniper = sniper
  end

  def call
    conn = Faraday.new(
      url: 'http://127.0.0.1:4567',
      headers: { 'X_BIDDER_IDENTITY' => 'abcd-123' },
    )

    response = conn.post("auction/#{sniper.item_id}/join")

    if response.status != 200
      raise "failed to complete"
    end
  end
end
