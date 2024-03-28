# frozen_string_literal: true

require 'json'

module FileWrite
  def self.json(key:, value:)
    File.open('sorting_time.json', 'w') do |f|
      f.write(JSON.pretty_generate(key => value))
      f.close
    end
  end
end
