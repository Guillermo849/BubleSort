# frozen_string_literal: true

module Validation
  private

  def validate_input_char?(num)
    true unless num.to_i.zero? && num != '0'
  end
end
