grids = File.read("day-13.in").split("\n\n").map { |block| block.lines.map { _1.chomp.chars } }

def find_mirror(grid, allowed_diffs = 0)
  for i in 1...grid.size
    size = [i, grid.size-i].min
    above = grid[i-size...i]
    below = grid[i...i+size].reverse

    diff_count = above.zip(below).sum do |ar, br|
      ar.zip(br).count { |a, b| a != b }
    end

    if diff_count == allowed_diffs
      return i
    end
  end

  0
end

part_1 = 0
part_2 = 0

grids.each do |grid|
  part_1 += find_mirror(grid) * 100
  part_1 += find_mirror(grid.transpose)

  part_2 += find_mirror(grid, 1) * 100
  part_2 += find_mirror(grid.transpose, 1)
end

puts part_1
puts part_2
