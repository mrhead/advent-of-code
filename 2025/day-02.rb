ranges = File.read("day-02.in").split(",").map { |s| Range.new(*s.split("-").map(&:to_i)) }

p1 = 0
p2 = 0

ranges.each do |range|
  range.each do |number|
    str = number.to_s
    len = str.length

    # example matches: 11, 1212
    if len.even? && str[0...len/2] == str[len/2..]
      p1 += number
    end

    # example matches: 11, 121212, 123123, 123123123
    for seq_len in 1..len/2
      repetitions = len / seq_len

      if (str[0...seq_len] * repetitions) == str
        p2 += number
        break
      end
    end
  end
end

puts p1, p2
