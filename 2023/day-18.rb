input = File.read("day-18.in").split("\n")

part_1_instructions = input.map do
  direction, length, _color = _1.split

  [direction, length.to_i]
end

part_2_instructions = input.map do
  _direction, _length, color = _1.split

  color = color.tr "#()", ""

  length, direction = color[0...-1].to_i(16), color[-1]

  [direction, length]
end

def lagoon_area(instructions)
  points = []
  boundary = 0

  x, y = 0, 0

  points = instructions.map do |direction, length|
    boundary += length

    case direction
    when "0", "R"
      x += length
    when "1", "D"
      y -= length
    when "2", "L"
      x -= length
    when "3", "U"
      y += length
    end

    [x, y]
  end

  # Shoelace formula
  area = 0
  points.each_with_index do |(x1, y1), i|
    x2, y2 = points[(i + 1) % points.length]
    area += x1 * y2 - x2 * y1
  end

  polygon_area = area.abs / 2

  # Pick's theorem
  lagoon_area = polygon_area + boundary / 2 + 1

  lagoon_area
end

puts lagoon_area(part_1_instructions)
puts lagoon_area(part_2_instructions)
