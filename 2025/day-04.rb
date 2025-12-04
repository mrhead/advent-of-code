grid = File.read("day-04.in").split

rows = grid.size
cols = grid.first.size

directions = [[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1]]

p1 = 0
p2 = 0
first_iteration = true

loop do
  rolls_for_removal = []

  for row in 0...rows
    for col in 0...cols
      next if grid[row][col] != "@"

      count = 0

      directions.each do |dr, dc|
        if row + dr >= 0 && row + dr < rows && col + dc >= 0 && col + dc < cols
          count += 1 if grid[row+dr][col+dc] == "@"
        end

        break if count >= 4
      end

      rolls_for_removal << [row, col] if count < 4
    end
  end

  break if rolls_for_removal.empty?

  rolls_for_removal.each do |row, col|
    grid[row][col] = "."
    p1 += 1 if first_iteration
    p2 += 1
  end

  first_iteration = false
end

puts p1, p2
