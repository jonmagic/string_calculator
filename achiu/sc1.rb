require 'minitest/autorun'

class NegativeNotAllowed < StandardError; end

def old_add(string)
  negatives = []
  delimiters = [",", "\n", ";"]
  if match = string.match(/\/\/(.*)\n*/)
    delimiters << Regexp.escape(match[1])
  end

  regex = Regexp.new(delimiters.join('|'))
  result = string.split(regex).inject(0) do |b,v|
    value = v.to_i
    negatives << value if value < 0
    b + value
  end
  raise NegativeNotAllowed, "negative numbers are not allowed: #{negatives}" if negatives.any?
  result
end


def add(string)
  delimiters = [",", "\n", ";"]
  match = string.match(/(?:\/\/(.*)\n)?(.*)/m)
  if match[1]
    foo = match[1].split("][")
    foo.each do |delimiter|
      delimiters << Regexp.escape(delimiter.gsub(/\[|\]/, ''))
    end
  end
  regex = Regexp.new(delimiters.join('|'))

  numbers   = match[2].split(regex).map(&:to_i)
  negatives = numbers.select { |num| num < 0 }
  numbers.reject! { |num| num > 1000 }
  raise NegativeNotAllowed, "negative numbers are not allowed: #{negatives}" if negatives.any?

  numbers.inject(0) { |b,v| b + v }
end


describe '#add' do
  it "returns 0 for ''" do
    assert_equal 0, add("")
  end

  it "returns 0 for ''" do
    assert_equal 0, add("")
  end

  it "returns 3 for '1,2'" do
    assert_equal 3, add("1,2")
  end

  it "accepts ',' or '\\n' as delimiter" do
    assert_equal 7, add("1,2\n4")
  end

  it "defaults a delimiter as ';'" do
    assert_equal 6, add("1;2;3")
  end

  it "accepts a custom delimiter" do
    assert_equal 6, add("//*\n1*2*3")
  end

  it "errors on negative numbers" do
    assert_raises NegativeNotAllowed, "negative numbers are not allowed: [-1,-2]" do
      add("-1,-2,3")
    end
  end

  it "drops numbers greater than 1000" do
    assert_equal 1001, add("1,1000,1002")
  end

  it "delimiters can be of any length and enclosed in brackets" do
    assert_equal 6, add("//[***]\n1***2***3")
  end

  it "multiple delimiters can exist" do
    assert_equal 6, add("//[***][^^^]\n1***2^^^3")
  end
end
