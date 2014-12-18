require "pry"

def add(input)
  delimiter = /,|\n/

  # if input starts with // then whatever follows / and preceeds \n is my delimiter
  if match_data = /\/\/(.+)\n(.+)/.match(input)
    delimiter = match_data[1]
    if match_data2 = /\[(.+)\]/.match(delimiter)
      delimiter = match_data2[1]
    end
    input = match_data[2]
  end

  numbers = input.split(delimiter).map(&:to_i).select {|n| n <= 1000 }
  negative_numbers = numbers.select {|n| n < 0 }
  raise "Negatives not allowed: #{negative_numbers.inspect}" if negative_numbers.any?

  numbers.inject(0) {|sum, number| sum += number }
end

def test(input, expected_output)
  result = begin
    add(input)
  rescue => e
    e.message
  end
  message = "Input: #{input.inspect}, Expected Output: #{expected_output}, Result: #{result} -> "

  if result == expected_output
    puts "#{message}Success"
  else
    puts "#{message}Failure"
  end
end

test("", 0)
test("1", 1)
test("1,2", 3)
test("1,2,3", 6)
test("1\n2,3", 6)
test("//;\n1;2", 3)
test("-1,-2,3", "Negatives not allowed: [-1, -2]")
test("2,1001", 2)
test("2,1000", 1002)
test("//[***]\n1***2***3", 6)