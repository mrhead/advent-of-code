# https://adventofcode.com/2023/day/3
#
# The code needs some cleanup. But who cares?

grid = File.read("day-03.in").split.map { |line| line.chars.to_a }

rows = grid.size
cols = grid.first.size

directions = [[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1]]

# Part 1 - collect all numbers adjacent to a symbol

numbers = []

for i in 0...rows
  number = ""
  is_adjacent = false

  for j in 0...cols
    if grid[i][j] =~ /\d/
      number += grid[i][j]

      unless is_adjacent
        directions.each do |dx, dy|
          next if i + dx < 0 || i + dx >= rows
          next if j + dy < 0 || j + dy >= cols

          is_adjacent = grid[i+dx][j+dy] =~ /[^\d.]/

          break if is_adjacent
        end
      end
    end

    if j + 1 >= cols || grid[i][j+1] !~ /\d/
      if is_adjacent
        numbers << number.to_i
      end

      number = ""
      is_adjacent = false
    end
  end
end

puts numbers.sum # p1

# part 2

numbers = {}
number_id = 1
possible_gears = []

# Find all numbers and represent them in the grid with their ID
for i in 0...rows
  j = 0
  while j < cols
    number = ""

    while grid[i][j] =~ /\d/
      number << grid[i][j]
      j += 1

      break if j >= cols
    end

    if number.length > 0
      for x in 1..number.length
        grid[i][j-x] = number_id
      end
      numbers[number_id] = number.to_i
      number_id += 1
    end

    j += 1
  end
end

# Find all * and check if they have two adjancent numbers. If they do,
# calculate the gear ratio and add it to the result.

p2 = 0

for i in 0...rows
  for j in 0...cols
    if grid[i][j] == "*"
      adjacent_numbers = Set.new

      directions.each do |dx, dy|
        next if i + dx < 0 || i + dx == rows
        next if j + dy < 0 || i + dy == cols
        if grid[i+dx][j+dy].is_a? Integer
          adjacent_numbers.add(grid[i+dx][j+dy])
        end
      end

      if adjacent_numbers.size == 2
        id_1, id_2 = adjacent_numbers.entries
        p2 += numbers[id_1] * numbers[id_2]
      end
    end
  end
end

puts p2
