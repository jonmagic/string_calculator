def add(string)
  delimiter = if string[0..1] == "//"
    delim, string = string.split("\n")
    delim = delim[2..-1]
    if delim.length == 1
      delim
    else
      Regexp.new(delim.split("][").map {|r| Regexp.escape(r.gsub(/\]|\[/, "")) }.join("|"))
    end
  end

  invalid_numbers = []

  sum = string.split(delimiter ? delimiter : /\n|,/).inject(0) do |sum, number|
    int = number.to_i
    if int >= 0 && int <= 1000
      sum += int
    elsif int < 0
      invalid_numbers << int
    end
    sum
  end

  raise "negatives not allowed: #{invalid_numbers.inspect}" if invalid_numbers.any?
  sum
end

def test(string, expected)
  result = add(string)
  if result == expected
    puts "success for: #{string.inspect}"
  else
    puts "failure: #{string.inspect}. Expected #{expected}, got #{result}"
  end
rescue => e
  if expected == e.message
    puts "success for: #{e.message}"
  else
    puts "failure: #{e.message}. Expected #{expected}, got #{e.message}"
  end
end

test("1,2", 3)
test("", 0)
test("1\n2,3", 6)
test("//;\n1;2", 3)
test("-1,-2", "negatives not allowed: [-1, -2]")
test("-1", "negatives not allowed: [-1]")
test("2,1001", 2)
test("//[***]\n1***2***3", 6)
test("//[*][%]\n1*2%3",6)
