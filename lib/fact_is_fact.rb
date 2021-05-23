require 'net/http'

class FactIsFact
  BASE_URI = 'http://numbersapi.com'.freeze
  TYPE = %w[trivia math year date].freeze

  class << self
    def return(type:, number:, **options)
      return 'not a valid type' unless TYPE.include?(type)

      query_params = URI.encode_www_form(options)
      number_facts_uri = URI("#{BASE_URI}/#{number}/#{type}?#{query_params}")
      Net::HTTP.get(number_facts_uri)
    end
  end

  class Error < StandardError; end
end
