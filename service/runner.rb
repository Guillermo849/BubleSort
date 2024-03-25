# frozen_string_literal: true

require './validate_number'
require './bubble_sort'

class Runner
  include ValidateNumber
  def run
    arr = []
    answer = 'Y'
    while answer == 'Y'
      begin
        puts 'Insert a number'
        num = gets.chomp
        validate(num)
        arr.push(num.to_i)
        puts 'Would you like to add another number?(Y/N)'
        answer = gets.chomp.upcase
      rescue ValidateNumber::IS_NOT_NUMERIC => e
        puts e.message
      end
    end
    print BubbleSort.sort(arr)
  end
end
