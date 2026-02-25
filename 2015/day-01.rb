# https://adventofcode.com/2015/day/1

input = File.read("day-01.in")

puts input.count("(")- input.count(")") # part 1

floor = 0

input.chars.each_with_index do |c, i|
  floor += c == "(" ? 1 : -1

  if floor == -1
    puts i + 1 # part 2
    break
  end
end
