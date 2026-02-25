# https://adventofcode.com/2015/day/3

directions = File.read("day-03.in").chomp

VECTORS = {
  ">" => [1, 0],
  "<" => [-1, 0],
  "^" => [0, -1],
  "v" => [0, 1]
}

def advance!(position, direction)
  dx, dy = VECTORS[direction]
  position[0] += dx
  position[1] += dy
end

santa = [0, 0]
visited_houses = Set[[0, 0]]

directions.each_char do |direction|
  advance!(santa, direction)
  visited_houses << santa.dup
end

puts visited_houses.size # part 1

santa = [0, 0]
robo_santa = [0, 0]
visited_houses = Set[[0, 0]]

directions.chars.each_with_index do |direction, i|
  actor = i.even? ? santa : robo_santa
  advance!(actor, direction)
  visited_houses << actor.dup
end

puts visited_houses.size # part 2
