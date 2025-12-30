directions, nodes = File.read("day-08.in").split("\n\n")

graph = {}

nodes.split("\n").each do |node|
  n = node.split(" = ")[0]
  left, right = node.split(" = ")[1].tr("()", "").split(",").map(&:strip)
  graph[n] = { "L" => left, "R" => right }
end

# part 1

current_node = "AAA"
step = 0

loop do
  dir = directions[step % directions.size]

  current_node = graph[current_node][dir]

  step += 1
  break if current_node == "ZZZ"
end

puts step

# part 2

a_nodes = graph.keys.select { _1.end_with?("A") }.to_set
z_nodes = graph.keys.select { _1.end_with?("Z") }.to_set

current_nodes = a_nodes
step = 0
z_counter = {}
new = Set.new

loop do
  dir = directions[step % directions.size]

  current_nodes.each do |current_node|
    new.add(graph[current_node][dir])
  end

  (current_nodes & z_nodes).each do |z|
    unless z_counter[z]
      z_counter[z] = step
    end
  end

  current_nodes.replace(new)
  new.clear

  step += 1
  break if z_counter.size == z_nodes.size
end

# find least common multiple
puts z_counter.values.reduce(1) { |result, n| result.lcm(n) }
