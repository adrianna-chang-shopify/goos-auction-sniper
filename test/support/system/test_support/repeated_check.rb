# frozen_string_literal: true
module TestSupport
  module RepeatedCheck
    def repeat_check_with_timeout(timeout = 5.seconds)
      timeout_time = timeout + Time.now.to_f

      loop do
        break if yield
        break if (timeout_time - Time.now.to_f) < 0
        sleep(0.1)
      end
    end
    module_function :repeat_check_with_timeout
  end
end
