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

require "strscan"

numbers = lines.map do |line|
  digits = []

  scanner = StringScanner.new(line)

  loop do
    if digit = DIGITS.keys.detect { |d| scanner.match?(d) }
      digits << DIGITS[digit]
    end

    scanner.pos += 1
    break if scanner.eos?
  end

  digits.first * 10 + digits.last
end

puts numbers.sum
