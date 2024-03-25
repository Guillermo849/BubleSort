# frozen_string_literal: true

module ArrSort
  def self.sort(arr)
    until check_sorted(arr)
      arr.each_with_index do |_number, index|
        next if arr[index + 1].nil?
        next unless arr[index] > arr[index + 1]

        num = arr[index]
        arr[index] = arr[index + 1]
        arr[index + 1] = num
      end
    end
    arr
  end

  def self.check_sorted(arr)
    arr.each_cons(2).all? { |a| (a[0] <=> a[1]) <= 0 }
  end
end
