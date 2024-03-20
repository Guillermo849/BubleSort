# frozen_string_literal: true

module ArrSort
  def self.descending(arr)
    loop do
      for i in 0..arr.length - 2 do
        next unless arr[i] > arr[i + 1]

        num = arr[i]
        arr[i] = arr[i + 1]
        arr[i + 1] = num
        dishorder = true
      end
      break unless dishorder
    end
    arr
  end
end

print ArrSort.descending([2, 1, 20, 3, 4, 7, 3, 9, 0, -10])
