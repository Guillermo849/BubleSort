# frozen_string_literal: true

require_relative './validation'
require_relative './sort_algorithm'

class Runner
  include Validation
  def run
    arr = []
    answer = 'Y'
    while answer == 'Y'
      begin
        puts 'Insert a number'
        num = gets.chomp
        raise NotIntegerError, 'The value is not an Integer' unless validate_integer(num)

        arr.push(num.to_i)
        puts 'Would you like to add another number?(Y/N)'
        answer = gets.chomp.upcase
      rescue NotIntegerError => e
        puts e.message
      end
    end
    print SortAlgorithm.bubble_sort(arr)
  end
end
