def add(string)
  match = /\/\/(.+)\n(.+)/.match string
  delimiter, string = if match
    if match[1].length == 1
      [match[1], match[2]]
    else
      delimiters = match[1].scan(/\[([^\]|.]+)\]/).flatten
      delimiters = delimiters.map { |d| Regexp.escape(d) }
      [Regexp.new(delimiters.join('|')), match[2]]
    end
  else
    [/,|\n/, string]
  end

  negatives = []
  result = string.split(delimiter).inject(0) do |sum, i|
    number = i.to_i
    if number < 0
      negatives << number
    else
      sum += number unless number > 1000
    end
    sum
  end

  raise "negatives not allowed #{negatives.inspect}" if negatives.any?

  result
end

def test(string, expected)
  result = add(string)
  if result == expected
    puts "success: add(#{string.inspect}) == #{expected}"
  else
    puts "failure: expected #{expected} but got #{result}"
  end
rescue => e
  if e.message == expected
    puts "success: #{e.message}"
  else
    puts "failure: expected #{expected} but got #{result}"
  end
end

test("1,2", 3)
test("1\n2", 3)
test("//;\n1;2", 3)
test("//;\n-1;-2", "negatives not allowed [-1, -2]")
test("1001,2", 2)
test("//[***]\n1***2***3", 6)
test("//[*][%]\n1*2%3", 6)
