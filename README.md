# FactIsFact

This gem returns a fact about any number provided. It is useful when you want
some random trivia or facts to be displayed about a number, on your website.

P.S: Gem internally uses http://numbersapi.com/ to return the results.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fact_is_fact'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fact_is_fact

## Usage
* `type` is one of `trivia`, `math`, `date`, or `year`. Defaults to `trivia` if omitted.
* `number` is
    * an `integer`, or
    * the keyword `random`, for which we will try to return a random available fact, or
    * a `day` of year in the form `month/day` (eg. 2/29, 1/09, 04/1), if `type` is `date`

basic examples
```ruby
# math fact
FactIsFact.return(type: 'math', number: '1234')
#=> "1234 is the smallest 4-digit number with increasing digits."

# date fact
FactIsFact.return(type: 'date', number: '2/29')
#=> "February 29th is the day in 1892 that St. Petersburg, Florida is incorporated."

# year fact
FactIsFact.return(type: 'year', number: '1234')
#=> "1234 is the year that the Manden region raises against the Kaniaga kingdom."

# trivia
FactIsFact.return(type: 'trivia', number: 'random')
#=> "150000000 is the number of items held in the British Library."
```

## Optional parameters

### Result in JSON format
Include the query parameter `json` or set the HTTP header `Content-Type` to `application/json` to return the fact and associated meta-data as a JSON object

```ruby
FactIsFact.return(type: 'math', number: '123', json: '')
#=> "{\n \"text\": \"123 is the 10^{th} Lucas number.\",\n \"number\": 123,\n \"found\": true,\n \"type\": \"math\"\n}"

FactIsFact.return(type: 'trivia', number: 'random', json: true)
#=> "{\n \"text\": \"88 is the number of keys on a piano (36 black and 52 white).\",\n \"number\": 88,\n \"found\": true,\n \"type\": \"trivia\"\n}"

FactIsFact.return(type: 'math', number: '12', json: nil)
#=> "{\n \"text\": \"12 is a superfactorial, being the product of the first three factorials.\",\n \"number\": 12,\n \"found\": true,\n \"type\": \"math\"\n}"
```
**Note**: you can pass any value to `json`, as long as the parameter is present, it does not matter what the value of the `json` parameter is.

### FRAGMENT
Return the fact as a sentence fragment that can be easily included as part of a larger sentence. This means that the first word is lowercase and ending punctuation is omitted. For trivia and math, a noun phrase is returned that can be used in a sentence like "We now have more users than [fact as fragment]!".

```ruby
FactIsFact.return(type: 'math', number: '13', fragment: '')
#=> "the number of Archimedian solids"

FactIsFact.return(type: 'math', number: '139', fragment: nil)
#=> "the number of unlabeled topologies with 5 elements"

FactIsFact.return(type: 'year', number: '1920', fragment: true)
#=> "the United States Congress refuses to ratify the Treaty of Versailles"
```
**Note**: you can pass any value to `fragment`, as long as the parameter is present, it does not matter what the value of the `fragment` parameter is.

### Not Found
The `notfound` field tells us what to do if the number is not found. You can give us

* `floor` to round down to the largest number that does have an associated fact, and return that fact.
```ruby
FactIsFact.return(type: 'math', number: '123123123', notfound: 'floor')
#=> "12988816 is the number of domino tilings of an 8\xC3\x978 checkerboard."
```

* `ceil`, which is like `floor` but rounds up to the smallest number that has an associated fact.
```ruby
FactIsFact.return(type: 'math', number: '123123123', notfound: 'ceil')
#=> "215000000 is the number of mathematical constants are collected on the Plouffe's Inverter as of 2010."
```

### Default message (if notfound)

* `default` to return one of our pre-written missing messages, or a message you supply with the default query field. This is the default behaviour.

```ruby
FactIsFact.return(type: 'math', number: '123123123', default: 'no facts found')
#=> "no facts found"
```

### MIN AND MAX
Restrict the range of values returned to the inclusive range [min, max] when random is given as the number.

```ruby
FactIsFact.return(type: 'trivia', number: 'random', min: 10, max: 20)
#=> "16 is the number of personality types in the Myers-Briggs classification system."
```

### BATCH REQUESTS
To get facts about multiple numbers in one request, specify ranges for number.

A number range (inclusive) is specified as min..max. Separate multiple ranges and individual numbers with , (a comma).

The response format will always be a JSON map from numbers to facts, of at most 100 numbers. The query parameter json may still be used to specify whether individual facts will be returned as string literals or JSON objects.

```ruby
FactIsFact.return(type: 'math', number: '1..3', json: '')
=> "{\n \"1\": \"1 is the most common leading digit in many sets of data, a consequence of Benford's law.\",\n \"2\": \"2 is a primorial, as well as its own factorial.\",\n \"3\": \"3 is the fourth open meandric number.\"\n}"

FactIsFact.return(type: 'math', number: '1..3,10,13,15', json: '')
=> "{\n \"1\": \"1 is also the first and second numbers in the Fibonacci sequence and is the first number in many other mathematical sequences.\",\n \"2\": \"2 is the number of n-Queens Problem solutions for n = 4.\",\n \"3\": \"3 is the first unique prime due to the properties of its reciprocal.\",\n \"10\": \"10 is the aliquot sum of only one number the discrete semiprime 14.\",\n \"13\": \"13 is the number of Archimedian solids.\",\n \"15\": \"15 is a triangular number, a hexagonal number, a pentatope number and the 4th Bell number.\"\n}"

FactIsFact.return(type: 'year', number: '1..3,10,13,15', json: '')
=> "{\n \"1\": \"1 is the year that Emperor Ping of Han China begins his reign and Wang Mang is re-instated as regent by Grand Empress Dowager Wang.\",\n \"2\": \"2 is the year that Cedeides becomes Archon of Athens.\",\n \"3\": \"3 is the year that Augustus adopts his grandson, Gaius Caesar, with the expectation that he will succeed him.\",\n \"10\": \"10 is the year that Ovid completes Tristia (the \\\"Sorrows\\\", 5 books) and Epistulae ex Ponto (Letters from the Black Sea, 4 books) describing the sadness of banishment.\",\n \"13\": \"13 is the year that Strabo publishes his book on the shape of the Earth.\",\n \"15\": \"15 is the year that Germanicus captures Thusnelda, the wife of Arminius.\"\n}"
```




## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abhinaykumar/fact_is_fact. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FactIsFact project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fact_is_fact/blob/master/CODE_OF_CONDUCT.md).
