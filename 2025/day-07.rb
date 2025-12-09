grid = File.readlines("day-07.in", chomp: true)

rows = grid.size-1
cols = grid.first.size

p1 = 0

for row in 0...rows
  for col in 0...cols-1
    if grid[row][col] == "S" || grid[row][col] == "|"
      if grid[row+1][col] == "^"
        p1 += 1
        grid[row+1][col-1] = "|" if col - 1 >= 0
        grid[row+1][col+1] = "|" if col + 1 < cols
      else
        grid[row+1][col] = "|"
      end
    end
  end
end

puts p1

def solve(grid, row, col, count, cache)
  return cache[[row, col]] if cache[[row, col]]

  return count if grid[row+1].nil?

  result = if grid[row+1][col] == "^"
             solve(grid, row+1, col-1, count, cache) + solve(grid, row+1, col+1, count, cache)
           else
             solve(grid, row+1, col, count, cache)
           end

  cache[[row, col]] = result
end

puts solve(grid, 0, grid.first.index("S"), 1, {}) # p2
