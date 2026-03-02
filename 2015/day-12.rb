# https://adventofcode.com/2015/day/12

require "json"

json = File.read("day-12.in")

puts json.scan(/-?\d+/).map(&:to_i).sum # part 1

data = JSON.parse(json)

def sum_numbers(value)
  case value
  when Integer
    value
  when Array
    value.sum { sum_numbers(_1) }
  when Hash
    if value.value?("red")
      0
    else
      value.values.sum { sum_numbers(_1) }
    end
  else
    0
  end
end

puts sum_numbers(data) # part 2
