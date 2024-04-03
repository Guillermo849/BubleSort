# frozen_string_literal: true

require_relative './validation'
require_relative './sort_algorithm'
require_relative './file_operations'
require 'json'

class Runner
  include Validation
  include FileOperations

  Error = Class.new(StandardError)
  NotIntegerError = Class.new(Error)
  BadRangeError = Class.new(Error)
  BadSizeError = Class.new(Error)

  def run
    answer = 'Y'
    @arr_status = []
    while answer == 'Y'
      begin
        arr = generate_array

        starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        puts SortAlgorithm.bundle_sort(arr)
        ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)

        buble_sorting_time = format('%f', (ending - starting).round(ROUND_TIME_NUMBER))
        puts "Time: #{buble_sorting_time}"

        starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        puts arr.sort
        ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)

        quick_sorting_time = format('%f', (ending - starting).round(ROUND_TIME_NUMBER))
        puts "Time: #{quick_sorting_time}"

        time_info = { Time.now => {
          time_for_qs: quick_sorting_time,
          time_for_bs: buble_sorting_time,
          element_count: arr.size
        } }

        write_json(information: time_info)

        puts 'Press Y to read the Json file'
        read_json if gets.chomp.upcase == 'Y'
        puts 'Press Y to sort a new array'
        answer = gets.chomp.upcase
        @array_generation_option = nil
        @arr_status = []
      rescue Error, FileNotFoundError => e
        puts e.message
      end
    end
  end

  private

  ROUND_TIME_NUMBER = 5
  MIN_ARR_SIZE_NUMBER = 1

  def generate_array
    return automated_array if @array_generation_option
    return manually_array if @array_generation_option == false

    @array_generation_option = true
    puts 'Type A for automated array generation or any key for manually?'
    return automated_array if gets.chomp.upcase == 'A'

    @array_generation_option = false
    manually_array
  end

  # Different ways to generate the arrays
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
    raise BadSizeError, "Size of arrray can't be lower than #{MIN_ARR_SIZE_NUMBER}" if size < MIN_ARR_SIZE_NUMBER

    start_of_range = ask_input_integer_number(text: 'Input the first number for the range of numbers')
    end_of_range = ask_input_integer_number(text: 'Input the last number for the range of numbers')

    if start_of_range > end_of_range
      raise BadRangeError,
            'Bad range, start of range is bigger than the end of range'
    end

    Array.new(size) { rand(start_of_range..end_of_range) }
  end

  # User integer input
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
