require 'net/http'

class FactIsFact
  BASE_URI = 'http://numbersapi.com'.freeze
  TYPE = %w[trivia math year date].freeze

  class << self
    def return(type:, number:)
      return 'not a valid type' unless TYPE.include?(type)

      number_facts_uri = URI("#{BASE_URI}/#{number}/#{type}")
      Net::HTTP.get(number_facts_uri)
    end
  end

  class Error < StandardError; end
end
