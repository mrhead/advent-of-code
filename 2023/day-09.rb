# https://adventofcode.com/2023/day/9

histories = File.read("day-09.in").split("\n").map { _1.split.map(&:to_i) }

part_1 = 0
part_2 = 0

histories.each do |history|
  sequences = [history]

  while !sequences.last.all? { _1.zero? }
    sequence = []

    sequences.last.each_cons(2) do |a, b|
      sequence << b - a
    end

    sequences << sequence
  end

  part_1 += sequences.reduce(0) { |result, sequence| result += sequence.last }
  part_2 += sequences.reverse.reduce(0) { |result, sequence| sequence.first - result }
end

puts part_1
puts part_2
