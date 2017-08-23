# numbers = ["", "1", "1,2"]
# 0, 1, 3

def add(string)
  a, b, _ = string.split(",")

  a.to_i + b.to_i
end

def assert_equal(expected, actual)
  if expected == actual
    puts "Passed"
  else
    puts "Failed: expected #{expected} but got #{actual}"
  end
end

assert_equal 0, add("")
assert_equal 1, add("1")
assert_equal 3, add("1,2")
