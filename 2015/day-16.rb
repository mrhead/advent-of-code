# https://adventofcode.com/2015/day/16

aunts = File.read("day-16.in").split("\n").map do |line|
  name, compounds_str = line.match(/\A(Sue \d+): (.*)/).captures
  compounds = compounds_str.scan(/(\w+): (\d+)/).map { |c, v| [c.to_sym, v.to_i] }.to_h

  {
    name: name,
    compounds: compounds
  }
end

TARGET_COMPOUNDS = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1
}

def matches_part_1?(compound, value)
  TARGET_COMPOUNDS[compound] == value
end

def matches_part_2?(compound, value)
  expected = TARGET_COMPOUNDS[compound]

  case compound
  when :cats, :trees
    value > expected
  when :pomeranians, :goldfish
    value < expected
  else
    value == expected
  end
end

def find_matching_aunt(aunts, matcher)
  aunts.find do |aunt|
    aunt[:compounds].all? do |compound, value|
      matcher.call(compound, value)
    end
  end

end

puts find_matching_aunt(aunts, method(:matches_part_1?))[:name]
puts find_matching_aunt(aunts, method(:matches_part_2?))[:name]
