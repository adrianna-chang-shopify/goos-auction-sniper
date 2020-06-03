# frozen_string_literal: true

require "test_helper"

Capybara.server_port = 12312
Dir[Rails.root.join('test', 'support', 'system', '**', '*.rb')].each { |file| require file }
