# frozen_string_literal: true

module TestSupport
  class Bidder
    attr_reader :identifier
    attr_reader :callback_url

    def initialize(identifier:, callback_url: nil)
      @identifier = identifier
      @callback_url = callback_url
    end

    def ==(other)
      other.class == self.class && identifier == other.identifier
    end
    alias :eql? :==

    def hash
      identifier.hash
    end
  end
end
