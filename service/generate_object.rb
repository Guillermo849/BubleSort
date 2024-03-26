# frozen_string_literal: true

module GenerateObject
  def self.generate_array(size:, small_number:, big_number:)
    arr = []
    (0...size).each { |i| arr[i] = rand(small_number..big_number) }

    arr
  end
end
