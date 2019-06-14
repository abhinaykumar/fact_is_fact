module FactIsFact
  class Random

    def initialize(args)
      @number = args[:number] || 'random'
      @fact_type = args[:fact_type]
      @base_uri = 'http://numbersapi.com'
    end

    def trivia
      number_facts_uri = URI("#{@base_uri}/#{@number}/#{@fact_type}")
      Net::HTTP.get(number_facts_uri)
    end
  end
end