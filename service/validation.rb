# frozen_string_literal: true

module Validation
  NotIntegerError = Class.new(StandardError)

  private

  def validate_integer(num)
    return true if num == '0'
    return true unless num.to_i.zero?

    false
  end
end
