require 'rubygems'
require 'bundler/setup'
require "active_support/core_ext/enumerable"
require "pry"

def Add(string)
  return 0 if string == ""
  result = /\/\/(.)\n(.*)/.match(string)
  delimiters = /,|\n/

  if result
    string, delimiter = result.to_a[0..1]
    delimiters = /,|\n|#{delimiter}/
  end

  numbers = string.split(delimiters).map(&:to_i)
  negatives = []
  numbers.each{|n| negatives << n if n < 0}
  raise "negatives not allowed: #{negatives.join(',')}" if negatives.size > 0
  numbers.sum
end

def test(input, expected_output)
  begin
    result = Add(input)
  rescue => e
    result = e.message
  end

  pass_or_fail = if result == expected_output
    "\e[32mpass"
  else
    "\e[31mfail"
  end
  puts "\e[0minput: #{input.inspect} output: #{result} #{pass_or_fail}"
end

test("", 0)
test("1", 1)
test("1,2", 3)
test("1,2,5,6,7,12,3", 36)
test("1,2\n3", 6)
test("//;\n1;2", 3)
test("1,-1,-2", "negatives not allowed: -1,-2")
