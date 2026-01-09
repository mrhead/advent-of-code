steps = File.read("day-15.in").chomp.split(",")

def hash(str)
  str.chars.inject(0) do |hash, char|
    hash += char.ord
    hash *= 17
    hash %= 256
  end
end

# part 1

puts steps.sum { hash(_1) }

# part 2

boxes = Hash.new { |h, k| h[k] = {} }

steps.each do |step|
  if step[-1] == "-"
    lens_label = step[..-2]
    box = hash(lens_label)

    boxes[box].delete(lens_label)
  else
    lens_label, focal_length = step.split("=")
    focal_length = focal_length.to_i
    box = hash(lens_label)

    boxes[box][lens_label] = focal_length
  end
end

part_2 = 0

boxes.sort_by { |k, _v| k }.each do |box_number, lenses|
  lenses.values.each_with_index do |focal_length, i|
    part_2 += (box_number + 1) * (i + 1) * focal_length
  end
end

puts part_2
