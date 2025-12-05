ranges, ingredients = File.read("day-5.in").split("\n\n")

ranges = ranges.split.map { |r| Range.new(*r.split("-").map(&:to_i)) }.sort_by(&:begin)
ingredients = ingredients.split.map(&:to_i)

merged_ranges = []
i = 0

while i < ranges.size
  current_end = ranges[i].end
  j = i + 1

  while j < ranges.size && ranges[j].begin <= current_end
    current_end = [current_end, ranges[j].end].max
    j += 1
  end

  merged_ranges << (ranges[i].begin..current_end)
  i = j
end

puts ingredients.count { |i| merged_ranges.any? { |r| r.include?(i) } } # part 1
puts merged_ranges.sum { |range| range.end - range.begin + 1 } # part 2
