banks = File.read("day-03.in").split.map { |str| str.chars.map(&:to_i) }

def get_max_joltage(bank, battery_count)
  max_joltage = []

  battery_index = -1

  for current_battery in 0...battery_count
    current_max_joltage = 0

    min_i = battery_index + 1
    max_i = bank.size - battery_count + current_battery

    for i in min_i..max_i
      if bank[i] > current_max_joltage
        current_max_joltage = bank[i]
        battery_index = i
      end
    end

    max_joltage << current_max_joltage
  end

  max_joltage.join.to_i
end

p1 = 0
p2 = 0

banks.each do |bank|
  p1 += get_max_joltage(bank, 2)
  p2 += get_max_joltage(bank, 12)
end

puts p1, p2
