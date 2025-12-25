points = File.readlines("day-09.in", chomp: true).map { _1.split(",").map(&:to_i) }

# Use compressed grid to mark points that are inside the polygon (true),
# outside the polygon (false), or unknown (nil).

xs = points.map { _1[0] }.uniq.sort
ys = points.map { _1[1] }.uniq.sort

x_index = {}
y_index = {}

xs.each_with_index { |x, i| x_index[x] = i + 1 }
ys.each_with_index { |y, i| y_index[y] = i + 1 }

compressed_grid = Array.new(ys.size + 2) { Array.new(xs.size + 2) }

points.each_with_index do |a, index|
  b = points[(index + 1) % points.size]

  x1, y1 = a
  x2, y2 = b

  cx1 = x_index[x1]
  cy1 = y_index[y1]
  cx2 = x_index[x2]
  cy2 = y_index[y2]

  cx1, cx2 = [cx1, cx2].sort
  cy1, cy2 = [cy1, cy2].sort

  # Mark the edge cells as true (inside the polygon).
  for x in cx1..cx2
    for y in cy1..cy2
      compressed_grid[y][x] = true
    end
  end
end

# Flood fill from (0,0) to mark outside area as false.
queue = [[0, 0]]
seen = Array.new(ys.size + 2) { Array.new(xs.size + 2) }

loop do
  break if queue.empty?
  x, y = queue.pop
  next if seen[y][x]
  seen[y][x] = true

  if compressed_grid[y][x].nil?
    compressed_grid[y][x] = false
  end

  [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dx, dy|
    nx = x + dx
    ny = y + dy
    next if nx < 0 || ny < 0 || nx >= compressed_grid[0].size || ny >= compressed_grid.size
    next if compressed_grid[ny][nx]

    queue << [nx, ny]
  end
end

# Mark all remaining nil cells as true (inside the polygon).
for y in 0...compressed_grid.size
  for x in 0...compressed_grid[0].size
    if compressed_grid[y][x].nil?
      compressed_grid[y][x] = true
    end
  end
end

# Check all rectangles defined by point pairs and find the largest area
# that is fully inside the polygon.
max_area = 0
points.combination(2).each_with_index do |(a, b), index|
  x1, y1 = a
  x2, y2 = b

  cx1 = x_index[x1]
  cy1 = y_index[y1]
  cx2 = x_index[x2]
  cy2 = y_index[y2]

  area = ((x2 - x1).abs + 1) * ((y2 - y1).abs + 1)

  next if area <= max_area

  cx1, cx2 = [cx1, cx2].sort
  cy1, cy2 = [cy1, cy2].sort

  valid = true
  for x in cx1..cx2
    for y in cy1..cy2
      unless compressed_grid[y][x]
        valid = false
        break
      end
    end
    break unless valid
  end

  max_area = area if valid
end

puts max_area
