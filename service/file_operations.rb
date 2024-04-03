# frozen_string_literal: true

module FileOperations
  FILE_NAME = 'sorting_time.json'
  FileNotFoundError = Class.new(StandardError)

  private

  def write_json(information:)
    file = File.read(FILE_NAME)
    information.merge!(JSON.parse(file))
    File.open(FILE_NAME, 'w') do |fw|
      fw.write(JSON.pretty_generate(information))
      fw.close
    end
  end

  def read_json
    raise FileNotFoundError, 'File not found' if File.file?("../#{FILE_NAME}")

    file = File.read(FILE_NAME)
    puts '------------------------------------------------'
    JSON.parse(file).each do |key, value|
      puts key
      value.each do |val_key, val_value|
        puts "\t #{val_key} - #{val_value}"
      end
    end
    puts "------------------------------------------------ \n"
  end
end
