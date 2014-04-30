def add(string)
  raise StandardError.new("invalid string: #{string}") if string[-1] == "\n"
  return 0 if string == nil || string == ""

  processed_string = /^(?:\/\/(.*)\n)?(.*)/.match(string)
  delimiter        = processed_string[1] ? processed_string[1] : /,|\n/
  string           = delimiter.is_a?(String) ? processed_string[2] : string

  numbers = string.split(delimiter).map &:to_f

  negative_numbers = numbers.select {|n| n < 0 }
  raise StandardError.new("invalid string: #{negative_numbers}") if negative_numbers.any?

  capped_numbers = numbers.reject {|n| n > 1000 }
  capped_numbers.inject(0) {|sum, number| sum += number }
end
