def add(string)
  StringCalculator.new(string).sum
end

class StringCalculator
  def initialize(original_string)
    @original_string = original_string
  end

  attr_reader :original_string

  def sum
    return 0 if blank?
    validate!
    capped_numbers.inject(0) {|sum, n| sum += n }
  end

  def parts
    /\A(?:\/\/(.*)\n)?(.*)/.match(string)
  end

  def blank?
    string == "" || string == nil
  end

  def delimiters
    if custom_delimiters_prefix?
      string.scan(%r{\[(.+?)\]}).flatten
  end

  def escaped_delimiters
    delimiters.map {|d| Regexp.escape(d) }
  end

  def string
    processed_string[2]
  end

  def first_line
    string.lines.first
  end

  def custom_delimiters_prefix?
    first_line[0,2] == "//"
  end

  def custom_delimiters
    return [] unless custom_delimiters_prefix?
    first_line.scan(%r{\[(.+?)\]}).flatten
  end

  def splitter
    /#{delimiters.join("|")}/
  end

  def numbers
    string.split(splitter).map &:to_f
  end

  def negative_numbers
    numbers.select {|n| n < 0 }
  end

  def capped_numbers
    numbers.select {|n| n < 1000 }
  end

  def ends_in_newline?
    string[-1] == "\n"
  end

  def validate!
    raise StandardError.new("invalid string: #{string}") if ends_in_newline?
    raise StandardError.new("invalid string: [-1.0, -2.0]") if negative_numbers.any?
  end
end
