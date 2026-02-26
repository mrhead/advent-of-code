# https://adventofcode.com/2015/day/5

strings = File.readlines("day-05.in", chomp: true)

def is_nice_part_1?(string)
  string.count("aeiou") >= 3 &&
    string.match?(/(.)\1/) && # repeating letter
    !string.match?(/ab|cd|pq|xy/) # does not include forbidden pair
end

def is_nice_part_2?(string)
  string.match?(/(..).*\1/) && # repeating pair
    string.match?(/(.).\1/) # repeating letter
end

puts strings.count { is_nice_part_1?(_1) }
puts strings.count { is_nice_part_2?(_1) }
