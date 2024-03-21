# frozen_string_literal: true

module ValidateNumber
  IS_NOT_NUMERIC = Class.new(StandardError)
  def self.validate(num)
    return if num == '0'
    raise IS_NOT_NUMERIC, 'The value given is not numeric' if num.to_i.zero?
  end
end
