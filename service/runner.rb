# frozen_string_literal: true

require_relative './validation'
require_relative './sort_algorithm'

class Runner
  include Validation

  NotIntegerError = Class.new(StandardError)
  BadRangeError = Class.new(StandardError)

  def run
    answer = 'Y'
    while answer == 'Y'
      begin
        arr = generate_array
        print "#{SortAlgorithm.bundle_sort(arr)} \n"
        puts 'Press Y to sort a new array'
        answer = gets.chomp.upcase
        @array_generation_option = nil
      rescue BadRangeError, NotIntegerError => e
        puts e.message
      end
    end
  end

  private

  def generate_array
    return automated_array if @array_generation_option
    return manually_array if @array_generation_option == false

    @array_generation_option = true
    puts 'Type A for automated array generation or any key for manually?'
    return automated_array if gets.chomp == 'A'

    @array_generation_option = false
    @arr_status = []
    manually_array
  end

  def manually_array
    answer = 'Y'
    while answer == 'Y'
      puts 'Insert a number'
      num = gets.chomp
      raise NotIntegerError, 'The value is not an Integer' unless validate_input_char?(num)

      @arr_status.push(num.to_i)
      puts 'Would you like to add another number?(Y/N)'
      answer = gets.chomp.upcase
    end
    @arr_status
  end

  def automated_array
    size = ask_input_integer_number(text: 'Input the size of the Array')
    start_of_range = ask_input_integer_number(text: 'Input the first number for the range of numbers')
    end_of_range = ask_input_integer_number(text: 'Input the last number for the range of numbers')

    if start_of_range > end_of_range
      raise BadRangeError,
            'Bad range, start of range is bigger than the end of range'
    end

    Array.new(size) { rand(start_of_range..end_of_range) }
  end

  def ask_input_integer_number(text:)
    values_correct = false
    until values_correct
      begin
        puts text
        num = gets.chomp
        raise NotIntegerError, 'The value is not an Integer' unless validate_input_char?(num)

        values_correct = true
      rescue NotIntegerError => e
        puts e.message
      end
    end
    num.to_i
  end
end
