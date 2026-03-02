# https://adventofcode.com/2015/day/13

pairs = {}

File.foreach("day-13.in") do |line|
  n1, change, amount, n2 = line.match(/\A(\w+) would (lose|gain) (\d+) .* (\w+)/).captures

  pairs[[n1, n2]] = change == "gain" ? amount.to_i : -amount.to_i
end

weights = {}
people = pairs.keys.flatten.uniq

people.combination(2) do |n1, n2|
  weights[[n1, n2]] = pairs[[n1, n2]] + pairs[[n2, n1]]
  weights[[n2, n1]] = pairs[[n1, n2]] + pairs[[n2, n1]]
end

def find_max_happiness(people, weights)
  max = -Float::INFINITY
  anchor = people.first

  (people - [anchor]).permutation do |perm|
    seating = [anchor, *perm]

    sum = seating.each_index.sum do |i|
      weights[[seating[i], seating[(i + 1) % seating.size]]]
    end

    max = [sum, max].max
  end

  max
end

puts find_max_happiness(people, weights) # part 1

people << "me"
people.each do |name|
  weights[[name, "me"]] = 0
  weights[["me", name]] = 0
end

puts find_max_happiness(people, weights) # part 2
