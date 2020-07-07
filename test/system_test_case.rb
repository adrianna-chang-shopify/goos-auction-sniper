require "application_system_test_case"

module ActionDispatch
  class SystemTestCase
    def self.start_application
      require 'byebug'; byebug
      # Thread.new (super)
    end
  end
end
