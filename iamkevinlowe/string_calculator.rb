def add(string)
  # start with base set of delimiters
  delimiters = [',', '\n']

  # update delimiters and string if custom delimiter supplied
  if string[0..1] == "//"
    delimiter, string = string.split(/\n/, 2)
    if delimiter[2] == "[" && delimiter[-1] == "]"
      custom_delimiters = delimiter[3..-2].split('][')
    else
      custom_delimiters = [delimiter[2..-1]]
    end
    delimiters += custom_delimiters.map { |delimiter| Regexp.escape(delimiter) }
  end

  # arrays to hold positive and negative numbers extracted from string
  negative_nums = []
  positive_nums = []

  # process string based on delimiters and update arrays
  string.split(/#{delimiters.join('|')}/).each do |num|
    num = num.to_i
    if num < 0
      negative_nums << num
    elsif num <= 1000
      positive_nums << num
    end
  end

  # raise error if negative numbers were found
  raise StandardError.new("negatives not allowed: #{negative_nums}") if negative_nums.any?

  # return sum of positive array
  positive_nums.reduce(0) { |sum, num| sum += num }
end

def test(test_name, expected, string)
  actual = add(string)

  if expected == actual
    puts "passed - #{test_name}"
  else
    puts "failed - #{test_name} - expected #{actual} to equal #{expected}"
  end
rescue StandardError => e
  if expected == e.message
    puts "passed - #{test_name}"
  else
    puts "failed - #{test_name} - expected #{e.message} to equal #{expected}"
  end
end

test("adds numbers in string", 3, "1,2")
test("empty string", 0,  "")
test("handles an unknown amount of numbers", 22, "4,5,6,7")
test("support , or newline between numbers", 7,  "1,2\n4")
test("does not pass comma and newline", 1,  "1,\n")
test("change delimiter", 3,  "//;\n1;2")
test("raises exception on negative numbers", "negatives not allowed: [-2, -3]",  "1,-2,-3")
test("numbers larger than 1000 should be ignored", 2, "2,1001")
test("delimiters can be of any length", 6, "//[***]\n1***2***3")
test("multiple delimiters", 6, "//[*][%]\n1*2%3")