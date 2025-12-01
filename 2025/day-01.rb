rotations = File.readlines("day-01.in")

current_position = 50
p1 = 0

rotations.each do |rotation|
  clicks = rotation.tr("LR", "-+").to_i

  current_position += clicks
  current_position = current_position % 100

  if current_position == 0
    p1 += 1
  end
end

puts p1

current_position = 50
p2 = 0

rotations.each do |rotation|
  clicks = rotation.tr("LR", "-+").to_i

  if clicks.positive?
    full_rotations, remainder = clicks.divmod(100)
    if current_position + remainder >= 100
      p2 += 1
    end
  else
    full_rotations, remainder = clicks.divmod(-100)
    if current_position + remainder <= 0 && current_position != 0
      p2 += 1
    end
  end

  p2 += full_rotations
  current_position = (current_position + clicks) % 100
end

puts p2
