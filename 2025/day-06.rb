grid = File.read("day-06.in").split("\n").map(&:split)

columns = grid[0..-2].transpose

p1 = 0

grid[-1].each_with_index.map do |operation, i|
  case operation
  when "+"
    p1 += columns[i].map(&:to_i).sum
  when "*"
    p1 += columns[i].map(&:to_i).inject(:*)
  end
end

puts p1

# part 2
#
# Transponse and reverse input so it easier to process.
#
# Original:
#
# 123 328  51 64 
#  45 64  387 23 
#   6 98  215 314
# *   +   *   +  
#
# Processed:
#
#   4
# 431
# 623+
#
# 175
# 581
#  32*
#
# 8
# 248
# 369+
#
# 356
# 24
# 1  *

problems = File.readlines("day-06.in", chomp: true).map(&:chars).transpose.reverse

p2 = 0

problems.each_with_object([]) do |problem, numbers|
  next if problem.all? { |c| c == " " }

  numbers << problem[0..-2].join.to_i

  next if problem[-1] == " "

  p2 += numbers.inject(problem[-1].to_sym)
  numbers.clear
end

puts p2
