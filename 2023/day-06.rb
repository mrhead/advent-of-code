# https://adventofcode.com/2023/day/6
#
# Brute force works, but let's use binary search to find the minimum and
# maximum hold times, then calculate the result as max_time - min_time + 1.
#
# Another option is to solve a system of inequalities, but that's a bit too
# much for me.

times, distances = File.read("day-06.in").split("\n").map { _1.split(":")[1].split.map(&:to_i) }

# Brute force part 1.
#
# p1 = 1
#
# times.zip(distances).each do |time, distance|
#   count = 0
#
#   (0..time).each do |hold|
#     if hold * (time - hold) > distance
#       count += 1
#     end
#   end
#
#   p1 *= count
# end
#
# puts p1

def new_record?(time:, distance:, hold_time:)
  hold_time * (time - hold_time) > distance
end

def min_time(time, distance)
  l = 0
  r = time / 2

  while l < r
    m = l + (r-l)/2

    if new_record?(time: time, distance: distance, hold_time: m)
      r = m
    else
      break if l == m
      l = m
    end
  end

  r
end

def max_time(time, distance)
  l = time / 2
  r = time

  while l < r
    m = l + (r-l)/2

    if new_record?(time: time, distance: distance, hold_time: m)
      break if l == m
      l = m
    else
      r = m
    end
  end

  l
end

# part 1

part_1 = times.zip(distances).inject(1) do |part_1, (time, distance)|
  min = min_time(time, distance)
  max = max_time(time, distance)

  part_1 *= max - min + 1
end

puts part_1

# part 2

time, distance = File.read("day-06.in").split("\n").map { _1.split(":")[1].split.join.to_i }

min = min_time(time, distance)
max = max_time(time, distance)

puts max - min + 1

# Brute force part 2.
#
# p2 = 1
#
# [[time, distance]].each do |time, distance|
#   count = 0
#
#   (0..time).each do |hold|
#     if hold * (time - hold) > distance
#       count += 1
#     end
#   end
#
#   p2 *= count
# end
#
# puts p2
