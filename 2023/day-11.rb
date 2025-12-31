# https://adventofcode.com/2023/day/11

grid = File.readlines("day-11.in", chomp: true).map(&:chars)

def row_prefix_sums(grid, expand_by)
  prefix_sums = []
  prev = 0

  for row in 0...grid.size
    if grid[row].all? { _1 == "." }
      offset = prev + expand_by
    else
      offset = prev + 1
    end

    prefix_sums << offset
    prev = offset
  end

  prefix_sums
end

def calculate_distances(grid, expand_by)
  row_prefix_sums = row_prefix_sums(grid, expand_by)
  col_prefix_sums = row_prefix_sums(grid.transpose, expand_by)

  galaxies = []

  for row in 0...grid.size
    for col in 0...grid.first.size
      if grid[row][col] == "#"
        galaxies << [row, col]
      end
    end
  end

  sum = 0

  galaxies.combination(2).each do |(r1, c1), (r2, c2)|
    sum += (row_prefix_sums[r1] - row_prefix_sums[r2]).abs + (col_prefix_sums[c1] - col_prefix_sums[c2]).abs
  end

  sum
end

puts calculate_distances(grid, 2)
puts calculate_distances(grid, 1_000_000)
