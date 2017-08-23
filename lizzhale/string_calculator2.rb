# numbers = ["", "1", "1,2"]
# 0, 1, 3

def add(string)
  delimiter = /,|\n/
  if string[-1] == "\n"
    raise "cannot end in newline"
  elsif match = string.match(/\A\/\/(.)(\s|\S)/)
    if match[2] != "\n"
      raise "newline required between custom delimiter and delimited numbers"
    end
    delimiter = match[1]
    string = string[3..-1]
  end
  sub_strings = string.split(delimiter)
  numbers = sub_strings.map(&:to_i)
  bad_numbers = numbers.select { |number| number < 0 }
  if bad_numbers.any?
    raise "negatives not allowed: #{bad_numbers.join(", ")}"
  end
  numbers.inject(0) { |sum, number| sum + number }
end

def assert_equal(expected, actual)
  if expected == actual
    puts "Passed"
  else
    puts "Failed: expected '#{expected}' but got '#{actual}'"
  end
end

def assert_raises(message)
  begin
    yield
    puts "Failed: expected '#{message}' but did not raise"
  rescue => exception
    assert_equal message, exception.message
  end
end

assert_equal 0, add("")
assert_equal 1, add("1")
assert_equal 3, add("1,2")
assert_equal 6, add("1,2,3")
assert_equal 45, add("9,8,7,6,5,4,3,2,1")
assert_equal 6, add("1\n2,3")
assert_raises("cannot end in newline") { add("1,\n") }
assert_equal 3, add("//;\n1;2")
assert_raises("newline required between custom delimiter and delimited numbers") { add("//;1;2") }
assert_raises("negatives not allowed: -1, -3") { add("1, -1, -3") }
