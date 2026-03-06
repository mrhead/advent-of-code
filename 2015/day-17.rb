# https://adventofcode.com/2015/day/17

containers = File.read("day-17.in").split("\n").map(&:to_i)

target = 150

valid_counts = []

(1..containers.size).each do |k|
  containers.combination(k) do |combination|
    valid_counts << k if combination.sum == target
  end
end

puts valid_counts.size # part 1

min_used = valid_counts.min
puts valid_counts.count(min_used) # part 2
