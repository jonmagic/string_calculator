def add(input)
  delimiters = [",", "\n"]
  if input[0..1] == "//"
    delimiter, input = input.split("\n", 2)
    delimiter = delimiter[2..-1]
    delimiters.push(delimiter)
  end
  input.split(Regexp.new(delimiters.join("|"))).inject(0) do |result, i|
    i = i.to_i
    if i >= 0
      result += i
    else
      raise ArgumentError.new("negatives not allowed")
    end
  end
end

def test(test_name, expected, actual)
  if expected == actual
    puts "#{test_name}: passed"
  else
    puts "#{test_name}: #{actual} does not equal #{expected}"
  end
end

def test_exception(message, error_class, &block)
  begin
    block.call
    puts "#{message}: no exception raised"
  rescue error_class => exception
    if exception.message == message
      puts "#{message}: test passed"
    else
      puts "#{message} does not equal #{exception}"
    end
  end
end

test("two numbers", 3, add("1,2"))
test("one number", 1, add("1"))
test("no numbers", 0, add(""))
test("support two delimiters", 6, add("1\n2,3"))
test("support configurable delimiters", 3, add("//;\n1;2"))
test_exception("negatives not allowed", ArgumentError) { add("1,-2") }
