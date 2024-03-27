# frozen_string_literal: true

require_relative './validation'
require_relative './sort_algorithm'

class Runner
  include Validation

  NotIntegerError = Class.new(StandardError)

  def run
    arr = []
    puts 'Generate Array automated or manually?(1/2)'
    if gets.chomp == '1'
      size = ask_input(question: 'Input the size of the Array')
      start_num_of_range = ask_input(question: 'Input the first number for the range of numbers')
      end_num_of_range = ask_input(question: 'Input the last number for the range of numbers')

      arr = if num1 < num2
              generate_array(size: size, start_num_of_range: num1, end_num_of_range: num2)
            else
              generate_array(size: size, start_num_of_range: num2, end_num_of_range: num1)
            end
    else
      answer = 'Y'
      while answer == 'Y'
        begin
          puts 'Insert a number'
          num = gets.chomp
          raise NotIntegerError, 'The value is not an Integer' unless validate_input_char?(num)

          arr.push(num.to_i)
          puts 'Would you like to add another number?(Y/N)'
          answer = gets.chomp.upcase
        rescue NotIntegerError => e
          puts e.message
        end
      end
    end
    print SortAlgorithm.bundle_sort(arr)
  end

  private

  def ask_input(question:)
    values_correct = false
    until values_correct
      begin
        puts question
        num = gets.chomp
        raise NotIntegerError, 'The value is not an Integer' unless validate_input_char?(num)

        values_correct = true
      rescue NotIntegerError => e
        puts e.message
      end
    end
    num.to_i
  end

  def generate_array(size:, start_num_of_range:, end_num_of_range:)
    arr = []
    (0...size).each { |i| arr[i] = rand(small_number..big_number) }

    arr
  end
end
