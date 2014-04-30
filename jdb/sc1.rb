def add(string)
  delimiters = [",", "\n"]

  if string[0,2] == "//"
    delimiters += string.lines.first.scan(%r{\[(.+?)\]}).flatten
  end

  delimiter_pattern = /#{delimiters.join('|')}/
  string.split(delimiter_pattern).inject(0) {|s,n| s += n.to_i }
end

def test(input, output)
  sum = add(input)
  puts "#{input.inspect} output #{sum}" unless sum == output
end

test("1,2", 3)
test("1,2,3", 6)
test("1,,2,4", 7)
test("1\n2,3", 6)
test("//[;]\n1;2;3", 6)
test("//[<foo>]\n1<foo>2<foo>3", 6)
test("//[foo][bar]\n1foo2bar3", 6)

puts "finished"
