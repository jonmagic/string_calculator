require 'pry'

class Error < StandardError

end

def add(numbers)
    if numbers.start_with?("//") 
        optional, numbers = numbers.split("\n", 2)
        delimiter = optional[2..-1]
        regexp = Regexp.new(delimiter)
    else
        regexp = Regexp.new(",|\n")
    end

    number_arr = numbers.split(regexp)
    total = 0
    negatives = []
    number_arr.each do |number|
        int_num = number.to_i
        
        if int_num < 0
            negatives << int_num
        else
            total += int_num
        end
    end
    if negatives.any?
        neg_str = negatives.join(" ")
        raise Error.new("negatives not allowed " + neg_str)
    end
    return total  
end


def test(numbers, expected)
    actual = begin
        add(numbers)
    rescue Error => error
        error.message
    end
    
    ans = actual == expected
    puts("Test add(#{numbers.inspect}) == #{expected}: #{ans}. \n Our answer: #{actual}")
end

test("", 0)
test("5", 5)
test("1,2", 3)
test("1,2,8,22", 33)
test("1\n5", 6)
test("1\n5,3,5\n6", 20)
test("//;\n1;2", 3)
test("//<=>\n3<=>2<=>11", 16)
test("9,-1,2,-33", "negatives not allowed -1 -33")
# puts(StringCalculator.Add("1\n2,8,22\n5"))
# puts(StringCalculator.Add(""))
# my_str = "1\n2,8,22"
# puts(my_str[1])
# puts(my_str[2])