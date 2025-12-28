# https://adventofcode.com/2025/day/12

data = File.read("day-12.in").split("\n\n")

presents = data[0..-2]
regions = data[-1]

presents = {}

data[0..-2].each do |present|
  number, shape = present.split(":")
  presents[number.to_i] = shape.count("#")
end

part_1 = 0

# Do not try to fit presents to the area, only check if the area is larger than
# required space.
regions.split("\n").each do |region|
  area = region.split(":").first.split("x").map(&:to_i).inject(:*)

  min_required_space = 0

  region.split(":")[1].split.map(&:to_i).each_with_index do |count, present_number|
    min_required_space += count * presents[present_number]
  end

  if area >= min_required_space
    part_1 += 1
  end
end

puts part_1
