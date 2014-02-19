def add(string)
  raise StandardError.new("invalid string: #{string}") if string[-1] == "\n"

  delimiters = [",", "\n"]

  if string[0,2] == "//"
    delimiters += string.lines.first.scan(%r{\[(.+?)\]}).flatten
  end

  delimiter_pattern = /#{delimiters.map {|d| Regexp.escape(d) }.join('|')}/
  numbers = string.split(delimiter_pattern).map &:to_f
  negative_numbers = numbers.select {|n| n < 0 }

  raise StandardError.new("invalid string: #{negative_numbers}") if negative_numbers.any?

  capped_numbers = numbers.reject {|n| n > 1000 }
  capped_numbers.inject(0) {|sum, number| sum += number }
end
