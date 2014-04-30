require "pry"

def add(string)
  a = if match = string.match(/\A\/\/(\[.*\])\n/)
    delimiters = match[1].scan(/\[([^\]]*)\]/).flatten

    string.split("\n", 2).last.split(/#{delimiters.join('|')}/)
  elsif match = string.match(/\A\/\/(.*)\n/)
    string.split(match[1])[1..-1]
  else
    string.split(/[,\n]/)
  end

  numbers = a.map(&:to_i)

  negative = numbers.select {|i| i < 0 }
  raise "NO WAY, BRO! #{negative.inspect}" if negative.length > 0

  numbers.inject(0) {|s,n| s += n }
end

puts "NOPE" unless add("1,2,3") == 6
puts "Nuhuh" unless add("") == 0
puts "WAT?" unless add("1,2,3,5,3,423,3,3,2,24") == 469
puts "newlines" unless add("1\n2\n3") == 6
puts "support delimiter" unless add("//<scrooge>\n1<scrooge>2") == 3
puts "h4ck0r delimiter" if add("buffer overflow\n//<scrooge>\n1<scrooge>2") == 3
puts "no negatives" if add("1,-1") == 0 rescue nil
puts "support delimiters" unless add("//[<scrooge>][:mcduck:][wtf]\n1<scrooge>2:mcduck:3") == 6
puts "finished"
