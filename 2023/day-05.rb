# https://adventofcode.com/2023/day/5

seeds, *maps = File.read("day-05.in").split("\n\n")
seeds = seeds.split(":")[1].split.map(&:to_i)

# part 1
maps.each do |map|
  ranges = map.split("\n")[1..].map { _1.split.map(&:to_i) }

  seeds = seeds.map do |seed|
    if range = ranges.detect { |_, src, len| src <= seed && seed < src + len }
      dest, src, _ = range
      dest + (seed - src)
    else
      seed
    end
  end
end

puts seeds.min

# part 2

seeds, *maps = File.read("day-05.in").split("\n\n")
seeds = seeds.split(":")[1].split.map(&:to_i).each_slice(2).map { |start, len| Range.new(start, start + len - 1) }

maps.each do |map|
  ranges = map.split("\n")[1..].map { _1.split.map(&:to_i) }.map { |dest, src, len| [Range.new(src, src + len - 1), dest - src] }
  new = []

  while seeds.any?
    seed = seeds.pop

    if (range, diff = ranges.detect { |range, _diff| range.overlap?(seed) })
      new << Range.new([range.begin, seed.begin].max + diff, [range.end, seed.end].min + diff)

      if seed.begin < range.begin
        seeds << Range.new(seed.begin, range.begin - 1)
      end

      if range.end < seed.end
        seeds << Range.new(range.end + 1, seed.end)
      end
    else
      new << seed
    end
  end

  seeds = new
end

puts seeds.map(&:begin).min
