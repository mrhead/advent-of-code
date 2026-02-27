# https://adventofcode.com/2015/day/8

lines = File.read("day-08.in").split("\n")

def memory_size(str)
  str[1...-1].gsub(/\\\\|\\"|\\x[0-9a-f]{2}/, "_").size
end

def code_size(str)
  str.inspect.size
end

puts lines.sum { |line| line.size - memory_size(line) } # part 1
puts lines.sum { |line| code_size(line) - line.size } # part 2
