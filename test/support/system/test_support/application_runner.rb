# frozen_string_literal: true

require 'capybara/dsl'
require 'capybara/minitest'

module TestSupport
  class ApplicationRunner
    include MiniTest::Assertions
    include Capybara::DSL

    attr_reader :assertions

    def initialize(assertions)
      # minitest expects there to be an assertions variable in the
      # class that includes MiniTest::Assertions. Passing in the
      # test class will allow us to call all assertions and see the
      # count of assertions in the console output.
      @assertions = assertions
    end

    def stop
      # noop rails system test takes care of starting and stopping the rails
      # server
    end
  end
end
