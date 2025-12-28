# https://adventofcode.com/2024/day/23

graph = Hash.new { |h, k| h[k] = Set.new }

File.readlines("day-23.in", chomp: true).each do |line|
  a, b = line.split("-")
  graph[a] << b
  graph[b] << a
end

part_1 = 0

# Ensure unique triangles by ensuring a < b < c
graph.keys.each do |a|
  graph[a].each do |b|
    next unless a < b

    (graph[a] & graph[b]).each do |c|
      next unless b < c

      part_1 += 1 if [ a, b, c ].any? { _1.start_with?("t") }
    end
  end
end

puts part_1

# For part 2, we should use
# https://en.wikipedia.org/wiki/Bron%E2%80%93Kerbosch_algorithm, but brute
# force is good enough.

graph.each do |c, set|
  set.add(c)
end

max_set_size = graph.values.first.size

(0..max_set_size).to_a.reverse.each do |set_size|
  graph.values.each do |set|
    subsets = set.to_a.combination(set_size)

    subsets.each do |subset|
      count = graph.values.count { (_1 & subset).size == subset.size }

      if count == subset.size
        puts subset.sort.join(",") # part_2
        exit
      end
    end
  end
end
