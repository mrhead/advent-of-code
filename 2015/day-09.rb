# https://adventofcode.com/2015/day/9
# Traveling Salesman Problem (brute force)
# Better algorithm: https://en.wikipedia.org/wiki/Held%E2%80%93Karp_algorithm

distances = {}
cities = []

File.read("day-09.in").split("\n").each do |line|
  from, to, distance = line.match(/(\w+) to (\w+) = (\d+)/).captures
  distance = distance.to_i

  distances[[from, to]] = distance
  distances[[to, from]] = distance

  cities << from
  cities << to
end

cities.uniq!

route_lenghts = cities.permutation.map do |path|
  path.each_cons(2).sum { distances[_1] }
end

puts route_lenghts.min # part 1
puts route_lenghts.max # part 1
