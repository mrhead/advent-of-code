# https://adventofcode.com/2015/day/15

ingredients = File.read("day-15.in").split("\n").map do |line|
  properties = line.scan(/-?\d+/)

  {
    capacity: properties[0].to_i,
    durability: properties[1].to_i,
    flavor: properties[2].to_i,
    texture: properties[3].to_i,
    calories: properties[4].to_i
  }
end

def compositions(n, total, prefix = [], &block)
  return enum_for(__method__, n, total, prefix) unless block_given?

  if n == 1
    yield prefix + [total]
    return
  end

  (0..total).each do |i|
    compositions(n - 1, total - i, prefix + [i], &block)
  end
end

max_score_part_1 = 0
max_score_part_2 = 0

compositions(ingredients.size, 100) do |amounts|
  totals = Hash.new(0)

  ingredients.zip(amounts) do |ingredient, amount|
    ingredient.each do |property, value|
      totals[property] += amount * value
    end
  end

  totals.each do |property, value|
    if value < 0
      totals[property] = 0
    end
  end

  score = totals.values_at(:capacity, :durability, :flavor, :texture).inject(:*)

  max_score_part_1 = [score, max_score_part_1].max

  if totals[:calories] == 500
    max_score_part_2 = [score, max_score_part_2].max
  end
end

puts max_score_part_1
puts max_score_part_2
