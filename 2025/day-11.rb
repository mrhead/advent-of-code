# https://adventofcode.com/2025/day/11

graph = {}

File.readlines("day-11.in").each do |line|
  source, destinations = line.split(":")

  graph[source] = destinations.split
end

@cache = {}
def count(graph, from, to)
  return @cache[[from, to]] if @cache[[from, to]]

  return 1 if from == to

  @cache[[from, to]] = graph.fetch(from, []).sum { count(graph, _1, to) }
end

part_1 = count(graph, "you", "out")

part_2 = count(graph, "svr", "dac") * count(graph, "dac", "fft") * count(graph, "fft", "out")
part_2 += count(graph, "svr", "fft") * count(graph, "fft", "dac") * count(graph, "dac", "out")

puts part_1, part_2
