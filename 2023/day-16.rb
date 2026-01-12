grid = File.read("day-16.in").split("\n")


def solve(grid, row, col, dir)
  grid = grid.map { _1.dup }

  seen = Set.new
  queue = [[row, col, dir]]

  directions = {
    up: [-1, 0],
    right: [0, 1],
    down: [1, 0],
    left: [0, -1]
  }

  while queue.any?
    position = queue.pop
    row, col, dir = position
    dr, dc = directions[dir]

    next if row < 0 || row >= grid.size
    next if col < 0 || col >= grid.first.size

    next if seen.include?(position)

    seen.add(position)

    case [dir, grid[row][col]]
    when [:right, "|"], [:left, "|"]
      queue << [row-1, col, :up]
      queue << [row+1, col, :down]
    when [:right, "\\"]
      queue << [row+1, col, :down]
    when [:right, "/"]
      queue << [row-1, col, :up]
    when [:left, "\\"]
      queue << [row-1, col, :up]
    when [:left, "/"]
      queue << [row+1, col, :down]
    when [:up, "\\"]
      queue << [row, col-1, :left]
    when [:up, "/"]
      queue << [row, col+1, :right]
    when [:up, "-"], [:down, "-"]
      queue << [row, col-1, :left]
      queue << [row, col+1, :right]
    when [:down, "\\"]
      queue << [row, col+1, :right]
    when [:down, "/"]
      queue << [row, col-1, :left]
    else
      queue << [row+dr, col+dc, dir]
    end
  end

  seen.map { |row, col, _pos| [row, col] }.uniq.count
end

puts solve(grid, 0, 0, :right) # part 1

part_2 = 0

for col in 0...grid.first.size
  part_2 = [part_2, solve(grid, 0, col, :down)].max
end

for col in 0...grid.first.size
  part_2 = [part_2, solve(grid, grid.size-1, col, :up)].max
end

for row in 0...grid.size
  part_2 = [part_2, solve(grid, row, 0, :right)].max
end

for row in 0...grid.size
  part_2 = [part_2, solve(grid, row, grid.first.size-1, :left)].max
end

puts part_2
