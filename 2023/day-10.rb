# https://adventofcode.com/2023/day/10

grid = File.readlines("day-10.in", chomp: true)

rows = grid.size
cols = grid.first.size

for row in 0...rows
  if start_col = grid[row].index("S")
    start_row = row
    break
  end
end

valid_moves = {
  "|" => [[-1, 0], [1, 0]],
  "-" => [[0, -1], [0, 1]],
  "L" => [[-1, 0], [0, 1]],
  "J" => [[-1, 0], [0, -1]],
  "7" => [[1, 0], [0, -1]],
  "F" => [[1, 0], [0, 1]],
}

start_moves = []

[[-1, 0], [0, 1], [1, 0], [0, -1]].each do |dr, dc|
  reversed_move = [-dr, -dc]
  if valid_moves[grid[start_row+dr][start_col+dc]]&.include?([-dr, -dc])
    start_moves << [dr, dc]
  end
end

start_char = valid_moves.find { |_k, v| v.sort == start_moves.sort }.first

grid[start_row][start_col] = start_char

queue = [[start_row, start_col]]
seen = Set.new

loop do
  row, col = queue.pop
  break if row.nil?

  seen.add([row, col])

  valid_moves[grid[row][col]].each do |dr, dc|
    queue << [row+dr, col+dc] unless seen.include?([row+dr, col+dc])
  end
end

puts seen.size / 2 # part 1

# Build three times bigger grid so we can use flood and fill to find all
# outside and inside points.

grid_2 = Array.new(rows * 3) { "." * (cols * 3) }

seen.each do |row, col|
  case grid[row][col]
  when "|"
    grid_2[row*3][col*3+1] = "X"
    grid_2[row*3+1][col*3+1] = "X"
    grid_2[row*3+2][col*3+1] = "X"
  when "-"
    grid_2[row*3+1][col*3] = "X"
    grid_2[row*3+1][col*3+1] = "X"
    grid_2[row*3+1][col*3+2] = "X"
  when "L"
    grid_2[row*3][col*3+1] = "X"
    grid_2[row*3+1][col*3+1] = "X"
    grid_2[row*3+1][col*3+2] = "X"
  when "J"
    grid_2[row*3][col*3+1] = "X"
    grid_2[row*3+1][col*3+1] = "X"
    grid_2[row*3+1][col*3] = "X"
  when "7"
    grid_2[row*3+2][col*3+1] = "X"
    grid_2[row*3+1][col*3+1] = "X"
    grid_2[row*3+1][col*3] = "X"
  when "F"
    grid_2[row*3+2][col*3+1] = "X"
    grid_2[row*3+1][col*3+1] = "X"
    grid_2[row*3+1][col*3+2] = "X"
  end
end

queue = [[0,0]]

loop do
  row, col = queue.pop
  break if row.nil?

  grid_2[row][col] = "O"

  [[-1, 0], [0, 1], [1, 0], [0, -1]].each do |dr, dc|
    nr = row + dr
    nc = col + dc

    next if nr < 0 || nr >= grid_2.size
    next if nc < 0 || nc >= grid_2.first.size

    if grid_2[nr][nc] == "."
      queue << [nr, nc]
    end
  end
end

part_2 = 0

for row in 0...rows
  for col in 0...cols
    part_2 += 1 if grid_2[row*3+1][col*3+1] == "."
  end
end

puts part_2
