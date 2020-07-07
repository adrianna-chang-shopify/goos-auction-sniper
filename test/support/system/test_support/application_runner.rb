# frozen_string_literal: true

module TestSupport
  class ApplicationRunner

    def initialize
      @application_thread = start_server
    end

    def stop
      puts "------- Stopping application thread -------"
      @application_thread.join
    end

    private

    def start_server
      require_relative '../../../../config/environment'

      Thread.new do
        begin
          puts "------- Thread: booting application -------"
          Capybara.app = Rack::Builder.new do
            run Rails.application
          end
        rescue StandardError => e
          $stderr << e.message
          $stderr << e.backtrace.join("\n")
        end
      end
    end
  end
end
