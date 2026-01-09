grid = File.read("day-14.in").split("\n")

ROWS = grid.size
COLS = grid.first.size

def tilt_north(grid)
  for col in 0...COLS
    target_row = 0

    for row in 0...ROWS
      case grid[row][col]
      when "#"
        target_row = row + 1
      when "O"
        if target_row < row
          grid[target_row][col] = "O"
          grid[row][col] = "."
        end
        target_row += 1
      end
    end
  end
end

def tilt_west(grid)
  for row in 0...ROWS
    target_col = 0

    for col in 0...COLS
      case grid[row][col]
      when "#"
        target_col = col + 1
      when "O"
        if target_col < col
          grid[row][target_col] = "O"
          grid[row][col] = "."
        end
        target_col += 1
      end
    end
  end
end

def tilt_south(grid)
  for col in 0...COLS
    target_row = ROWS-1

    for row in (0...ROWS).to_a.reverse
      case grid[row][col]
      when "#"
        target_row = row - 1
      when "O"
        if target_row > row
          grid[target_row][col] = "O"
          grid[row][col] = "."
        end
        target_row -= 1
      end
    end
  end
end

def tilt_east(grid)
  for row in 0...ROWS
    target_col = COLS-1

    for col in (0...COLS).to_a.reverse
      case grid[row][col]
      when "#"
        target_col = col - 1
      when "O"
        if target_col > col
          grid[row][target_col] = "O"
          grid[row][col] = "."
        end

        target_col -= 1
      end
    end
  end
end

def calculate_load(grid)
  grid.each_with_index.sum { |row, i| row.count("O") * (ROWS - i) }
end

tilt_north(grid)

puts calculate_load(grid) # part 1

# part 2

TOTAL_CYCLES = 1_000_000_000

# finish the cycle
tilt_west(grid)
tilt_south(grid)
tilt_east(grid)

def perform_cycle(grid)
  tilt_north(grid)
  tilt_west(grid)
  tilt_south(grid)
  tilt_east(grid)
end

def dup_grid(grid)
  grid.map { _1.dup }
end

completed_cycles = 1
states_to_cycles = {}
cycles_to_grids = {}
cycle_length = nil

# Perform cycles until we find a repeated state
loop do
  states_to_cycles[grid.join] = completed_cycles
  cycles_to_grids[completed_cycles] = dup_grid(grid)

  perform_cycle(grid)

  completed_cycles += 1

  if states_to_cycles[grid.join]
    cycle_length = completed_cycles - states_to_cycles[grid.join]
    break
  end
end

remaining_cycles = (TOTAL_CYCLES - completed_cycles) % cycle_length
target_cycle = completed_cycles - cycle_length + remaining_cycles

puts calculate_load(cycles_to_grids[target_cycle]) # part 2
