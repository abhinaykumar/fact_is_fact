require 'fact_is_fact'

describe FactIsFact do
  it 'Random trivia about the numbers' do
    expect(FactIsFact::Random.new(number: 42).trivia.class).to eql(String)
  end
end