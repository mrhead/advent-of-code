games = File.readlines("day-02.in")

CUBE_COUNTS = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

p1 = 0
p2 = 0

games.each do |game|
  game_id = game.match(/Game (\d+):/)[1].to_i
  color_counts = game.scan(/(\d+) (red|green|blue)/)

  is_possible = true
  minimums = Hash.new(0)

  color_counts.each do |count, color|
    count = count.to_i

    is_possible = false if CUBE_COUNTS[color] < count
    minimums[color] = [count, minimums[color]].max
  end

  p1 += game_id if is_possible
  p2 += minimums.values.reduce(:*)
end

puts p1, p2
