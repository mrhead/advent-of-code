points = File.readlines("day-09.in", chomp: true).map { _1.split(",").map(&:to_i) }

puts points.combination(2).map { |a, b| ((a[0]-b[0]).abs + 1) * ((a[1]-b[1]).abs + 1) }.max
