# https://adventofcode.com/2023/day/4

cards = File.readlines("day-04.in")

p1 = 0

# how many (original + copies) of each card do we have?
card_counts = {}
cards.size.times { |n| card_counts[n + 1] = 1 } # count each original

cards.each_with_index do |card, i|
  current_card = i + 1
  winning_numbers, my_numbers = card.match(/ ([\d ]+) \| ([\d ]+)/)[1..2]

  winning_numbers = winning_numbers.split
  my_numbers = my_numbers.split

  match_count = (winning_numbers & my_numbers).size

  if match_count > 0
    p1 += 2 ** (match_count - 1)
  end

  match_count.times do |n|
    card_counts[current_card + n + 1] += card_counts[current_card]
  end
end

puts p1
puts card_counts.values.sum # p2
