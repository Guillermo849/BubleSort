# frozen_string_literal: true

require_relative './validation'
require_relative './sort_algorithm'
require 'json'

class Runner
  include Validation

  Error = Class.new(StandardError)
  NotIntegerError = Class.new(Error)
  BadRangeError = Class.new(Error)
  BadSizeError = Class.new(Error)

  def run
    @time_of_execution = Time.now
    answer = 'Y'
    @arr_status = []
    while answer == 'Y'
      begin
        sort_arr_calculate_time(generate_array)
        puts "Time: #{@sorting_time}"
        write_json(information: { Time.now => @sorting_time })
        puts 'Press Y to sort a new array'
        answer = gets.chomp.upcase
        @array_generation_option = nil
        @arr_status = []
      rescue Error => e
        puts e.message
      end
    end
  end

  private

  def sort_arr_calculate_time(arr)
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    print "#{SortAlgorithm.bundle_sort(arr)} \n"
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @sorting_time = "Time: #{(ending - starting).round(7)}"
  end

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
    raise BadSizeError, "Size of arrray can't be lower than 1" if size < 1

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

  # File Operations
  def write_json(information:)
    file = File.read('sorting_time.json')
    information.merge!(JSON.parse(file))
    File.open('sorting_time.json', 'w') do |fw|
      fw.write(JSON.dump(information))
      fw.close
    end
  end
end
