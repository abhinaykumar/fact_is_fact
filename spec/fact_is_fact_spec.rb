require 'fact_is_fact'

describe FactIsFact do
  it 'Random trivia about the numbers' do
    expect(FactIsFact.return(type: 'math', number: '1234').to_i).to eql(1234)
  end
end
