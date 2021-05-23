require 'fact_is_fact'

describe FactIsFact do
  it 'Random trivia about the numbers' do
    expect(FactIsFact.return(type: 'math', number: '1234').to_i).to eql(1234)
  end

  it 'Returns default value, if no facts found' do
    expect(FactIsFact.return(type: 'math', number: '123123', default: 'no facts for this number')).to eql('no facts for this number')
  end
end
