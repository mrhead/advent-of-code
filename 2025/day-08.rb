coords = File.readlines("day-08.in", chomp: true).map { |l| l.split(",").map(&:to_i) }
circuits = coords.map { |a| Set.new([a]) }

def distance(a, b)
  x1, y1, z1 = a
  x2, y2, z2 = b

  Math.sqrt((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)
end

possible_connections = []

for i in 0...coords.size-1
  for j in i+1...coords.size
    possible_connections << [distance(coords[i], coords[j]), coords[i], coords[j]]
  end
end

possible_connections.sort_by! { |d, _a, _b| d }

n = 1

loop do
  _d, a, b = possible_connections.shift

  c_a = circuits.find { |c| c.include?(a) }
  c_b = circuits.find { |c| c.include?(b) }

  if c_a != c_b
    c_a.merge(c_b)
    circuits.delete(c_b)
  end

  if n == 1000
    puts circuits.sort_by { |c| c.size }.last(3).map(&:size).inject(:*) # p1
  end

  if circuits.size == 1
    puts a[0] * b[0] # p2
    break
  end

  n += 1
end
