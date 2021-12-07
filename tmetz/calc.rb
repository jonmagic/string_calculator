require 'pry'

class StringCalculator

    # 1.
    # Create a simple String calculator with a method signature:
    # ———————————————
    # int Add(string numbers)
    # ———————————————
    # The method can take up to two numbers, separated by commas, and will return their sum. 
    # for example “” or “1” or “1,2” as inputs.
    # (for an empty string it will return 0) 
    #
    # 2.
    # Allow the Add method to handle an unknown amount of numbers
    #
    # 3.
    # Allow the Add method to handle new lines between numbers (instead of commas).
    # the following input is ok: “1\n2,3” (will equal 6)
    # the following input is NOT ok: “1,\n” (not need to prove it - just clarifying)

    def self.Add(numbers)
        
        number_arr = numbers.split(/,|\n/)
        total = 0
        number_arr.each do |number|
            total += number.to_i
        end
        return total  
    end
end

puts(StringCalculator.Add("1\n2,8,22"))
puts(StringCalculator.Add(""))