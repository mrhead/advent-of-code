points = File.readlines("day-09.in", chomp: true).map { _1.split(",").map(&:to_i) }

# Use compressed grid to mark points that are inside the polygon (1) or outside
# the polygon (0). Add padding and extra rows and columns for spaces between
# points.

xs = points.map { _1[0] }.uniq.sort
ys = points.map { _1[1] }.uniq.sort

x_index = {}
y_index = {}

xs.each_with_index { |x, i| x_index[x] = i * 2 + 1 }
ys.each_with_index { |y, i| y_index[y] = i * 2 + 1 }

compressed_grid = Array.new(ys.size * 2 + 1) { Array.new(xs.size * 2 + 1, 0) }

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

  for x in cx1..cx2
    for y in cy1..cy2
      # Mark edges as 1 (inside)
      compressed_grid[y][x] = 1
    end
  end
end

# Flood fill from (0,0) to mark outside area as 0.
queue = [[0, 0]]
outside = Set.new

while queue.any?
  x, y = queue.pop

  if compressed_grid[y][x] == 0
    outside.add([x, y])
  end

  [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dx, dy|
    nx = x + dx
    ny = y + dy

    next if nx < 0 || ny < 0 || nx >= compressed_grid[0].size || ny >= compressed_grid.size
    next if compressed_grid[ny][nx] == 1
    next if outside.include?([nx, ny])

    queue << [nx, ny]
  end
end

# Mark all non-outside points as inside (1).
for y in 0...compressed_grid.size
  for x in 0...compressed_grid[0].size
    unless outside.include?([x, y])
      compressed_grid[y][x] = 1
    end
  end
end

# Calculate prefix sums for fast area queries.
prefix_sums = Array.new(compressed_grid.size) { Array.new(compressed_grid[0].size, 0) }

for y in 0...compressed_grid.size
  for x in 0...compressed_grid[0].size
    top = y > 0 ? prefix_sums[y-1][x] : 0
    left = x > 0 ? prefix_sums[y][x-1] : 0
    topleft = x > 0 && y > 0 ? prefix_sums[y-1][x-1] : 0
    count = compressed_grid[y][x]

    sum = top + left - topleft + count
    prefix_sums[y][x] = sum
  end
end

# Check all rectangles defined by point pairs and find the largest area
# that is fully inside the polygon.
max_area = 0
max_rectangle = nil

points.combination(2) do |a, b|
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

  expected_count = (cx2 - cx1 + 1) * (cy2 - cy1 + 1)
  top = cy1 > 0 ? prefix_sums[cy1-1][cx2] : 0
  left = cx1 > 0 ? prefix_sums[cy2][cx1-1] : 0
  topleft = cx1 > 0 && cy1 > 0 ? prefix_sums[cy1-1][cx1-1] : 0
  count = prefix_sums[cy2][cx2] - top - left + topleft

  if count == expected_count
    max_area = area
    max_rectangle = [x1, y1, x2, y2]
  end
end

puts max_area

# def print_grid(grid)
#   for y in 0...grid.size
#     for x in 0...grid[0].size
#       print grid[y][x] == 1 ? "#" : "."
#     end
#     puts
#   end
#   puts
# end
# max_x = xs.max
# max_y = ys.max
#
# grid = Array.new(max_y + 2) { Array.new(max_x + 2, 0) }
#
# for i in 0...points.size
#   a = points[i]
#   b = points[(i + 1) % points.size]
#
#   x1, y1 = a
#   x2, y2 = b
#
#   if x1 == x2
#     for y in [y1, y2].min..[y1, y2].max
#       grid[y][x1] = 1
#     end
#   elsif y1 == y2
#     for x in [x1, x2].min..[x1, x2].max
#       grid[y1][x] = 1
#     end
#   end
# end
#
# print_grid(grid)
# print_grid(compressed_grid)
#
# for y in 0...grid.size
#   for x in 0...grid[0].size
#     if max_rectangle &&
#        x >= [max_rectangle[0], max_rectangle[2]].min &&
#        x <= [max_rectangle[0], max_rectangle[2]].max &&
#        y >= [max_rectangle[1], max_rectangle[3]].min &&
#        y <= [max_rectangle[1], max_rectangle[3]].max
#       print "\e[32m" # green color
#     end
#
#     print grid[y][x] == 1 ? "#" : "."
#
#     if max_rectangle &&
#        x >= [max_rectangle[0], max_rectangle[2]].min &&
#        x <= [max_rectangle[0], max_rectangle[2]].max &&
#        y >= [max_rectangle[1], max_rectangle[3]].min &&
#        y <= [max_rectangle[1], max_rectangle[3]].max
#       print "\e[0m" # reset color
#     end
#   end
#   puts
# end
#
# puts
# puts max_area
# pp prefix_sums
