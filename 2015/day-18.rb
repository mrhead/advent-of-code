grid = File.read("day-18.in").split("\n")

ROWS = grid.size
COLS = grid.first.size

iterations = 100

NEIGHBORS = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]

def count_neighbors(grid, row, col)
  NEIGHBORS.count do |dr, dc|
    nr = row + dr
    nc = col + dc

    nr.between?(0, ROWS-1) && nc.between?(0, COLS-1) && grid[nr][nc] == "#"
  end
end

def step(grid, stuck_corners: false)
  new_grid = Array.new(ROWS) { "." * COLS }

  for row in 0...ROWS
    for col in 0...COLS
      if stuck_corners && [[0, 0], [0, COLS-1], [ROWS-1, 0], [ROWS-1, COLS-1]].include?([row, col])
        new_grid[row][col] = "#"
        next
      end

      neighbors = count_neighbors(grid, row, col)

      if grid[row][col] == "#" && neighbors.between?(2, 3)
        new_grid[row][col] = "#"
      elsif grid[row][col] == "." && neighbors == 3
        new_grid[row][col] = "#"
      end
    end
  end

  new_grid
end

def run(grid, iterations: 100, stuck_corners: false)
  grid = grid.map(&:dup)

  if stuck_corners
    grid[0][0] = grid[0][-1] = grid[-1][0] = grid[-1][-1] = "#"
  end

  iterations.times do
    grid = step(grid, stuck_corners: stuck_corners)
  end

  grid.join.count("#")
end

puts run(grid) # part 1
puts run(grid, stuck_corners: true) # part 2
