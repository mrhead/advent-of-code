# https://adventofcode.com/2015/day/6

instructions = File.read("day-06.in").split("\n").
  map { _1.scan(/^(turn on|turn off|toggle) (\d+,\d+) through (\d+,\d+)$/).first }.
  map { |(action, from, to)| [action, from.split(",").map(&:to_i), to.split(",").map(&:to_i)] }

grid = Array.new(1000) { Array.new(1000, 0) }

def apply_part_1(grid, (action, from, to))
  x1, y1 = from
  x2, y2 = to

  x1, x2 = [x1, x2].sort
  y1, y2 = [y1, y2].sort

  for y in y1..y2
    case action
    when "turn on"
      grid[y][x1..x2] = [1] * (x2 - x1 + 1)
    when "turn off"
      grid[y][x1..x2] = [0] * (x2 - x1 + 1)
    when "toggle"
      grid[y][x1..x2] = grid[y][x1..x2].map { _1 ^ 1 }
    else
      raise "Unexpected action"
    end
  end
end

instructions.each { apply_part_1(grid, _1) }

puts grid.flatten.sum # part 1

grid = Array.new(1000) { Array.new(1000, 0) }

def apply_part_2(grid, (action, from, to))
  x1, y1 = from
  x2, y2 = to

  x1, x2 = [x1, x2].sort
  y1, y2 = [y1, y2].sort

  for y in y1..y2
    case action
    when "turn on"
      (x1..x2).each { |x| grid[y][x] += 1 }
    when "turn off"
      (x1..x2).each { |x| grid[y][x] -= 1 if grid[y][x] > 0 }
    when "toggle"
      (x1..x2).each { |x| grid[y][x] += 2 }
    else
      raise "Unexpected action"
    end
  end
end

instructions.each { apply_part_2(grid, _1) }

puts grid.flatten.sum # part 2
