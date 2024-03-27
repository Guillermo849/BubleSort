# frozen_string_literal: true

module SortAlgorithm
  def self.bundle_sort(arr)
    (0...arr.size).each do |num1|
      (0..arr.size - 1).each do |num2|
        next unless arr[num2] > arr[num1]

        num = arr[num1]
        arr[num1] = arr[num2]
        arr[num2] = num
      end
    end
    arr
  end
end
