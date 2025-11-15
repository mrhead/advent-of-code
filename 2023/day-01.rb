# https://adventofcode.com/2023/day/1

lines = File.readlines("day-01.in")

DIGITS = {
  "0" => 0,
  "1" => 1,
  "2" => 2,
  "3" => 3,
  "4" => 4,
  "5" => 5,
  "6" => 6,
  "7" => 7,
  "8" => 8,
  "9" => 9,
  "one"   => 1,
  "two"   => 2,
  "three" => 3,
  "four"  => 4,
  "five"  => 5,
  "six"   => 6,
  "seven" => 7,
  "eight" => 8,
  "nine"  => 9
}

PATTERN_1 = Regexp.union(DIGITS.keys.first(10))
PATTERN_2 = Regexp.union(DIGITS.keys)

p1 = lines.map do |line|
  digits = line.scan(/(?=(#{PATTERN_1}))/).flatten

  DIGITS[digits.first] * 10 + DIGITS[digits.last]
end.sum

p2 = lines.map do |line|
  digits = line.scan(/(?=(#{PATTERN_2}))/).flatten

  DIGITS[digits.first] * 10 + DIGITS[digits.last]
end.sum

puts p1, p2
