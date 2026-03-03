# https://adventofcode.com/2015/day/14

Reindeer = Struct.new(:name, :speed, :fly_time, :rest_time) do
  def cycle_duration
    fly_time + rest_time
  end

  def distance_at(seconds)
    full_cycles, remainder = seconds.divmod(cycle_duration)
    flying_seconds = full_cycles * fly_time + [remainder, fly_time].min

    flying_seconds * speed
  end

  def flying_at?(second)
    (second - 1) % cycle_duration < fly_time
  end
end

reindeer = File.foreach("day-14.in").map do |line|
  match = line.match(/\A(\w+) can fly (\d+) km\/s for (\d+) seconds, .* for (\d+) seconds./)

  Reindeer.new(
    match[1],
    match[2].to_i,
    match[3].to_i,
    match[4].to_i
  )
end

race_duration = 2503

puts reindeer.map { _1.distance_at(race_duration) }.max # part 1

distances = Hash.new(0)
scores = Hash.new(0)

(1).upto(race_duration) do |second|
  reindeer.each do |reindeer|
    if reindeer.flying_at?(second)
      distances[reindeer.name] += reindeer.speed
    end
  end

  max_distance = distances.values.max

  reindeer.each do |reindeer|
    if distances[reindeer.name] == max_distance
      scores[reindeer.name] += 1
    end
  end
end

puts scores.values.max # part 2
