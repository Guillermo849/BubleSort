# frozen_string_literal: true

module ArrSort
  def self.sort(arr)
    unless check_sorted(arr)
      for i in 0..arr.length - 2 do
        next unless arr[i] > arr[i + 1]

        num = arr[i]
        arr[i] = arr[i + 1]
        arr[i + 1] = num
      end
      sort(arr)
    end
    arr
  end

  def self.check_sorted(arr)
    for i in 0..arr.length - 2 do
      next unless arr[i] > arr[i + 1]

      return false
    end
    true
  end
end

print ArrSort.sort([2, 1, 20, 3, 4, 7, 3, 9, 0, -10])
