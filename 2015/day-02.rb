dimensions = File.read("day-02.in").split("\n").map { _1.split("x").map(&:to_i).sort }

def wrapping_paper(a, b, c)
  2 * (a * b + b * c + c * a) + a * b
end

def ribbon(a, b, c)
  2 * a + 2 * b + a * b * c
end

puts dimensions.sum { wrapping_paper(*_1) }
puts dimensions.sum { ribbon(*_1) }
