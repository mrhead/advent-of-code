# https://adventofcode.com/2023/day/7

class Hand
  include Comparable

  RANKS = {
    :five_of_a_kind => 7,
    :four_of_a_kind => 6,
    :full_house => 5,
    :three_of_a_kind => 4,
    :two_pair => 3,
    :one_pair => 2,
    :high_card => 1
  }

  attr_reader :cards

  def initialize(card_labels)
    @cards = card_labels.chars.map do |label|
      Card.new(label)
    end
  end

  def type
    counts = Hash.new(0)
    @cards.each do |card|
      counts[card.label] += 1
    end
    sorted_counts = counts.values.sort.reverse

    case sorted_counts
    when [5]
      :five_of_a_kind
    when [4, 1]
      :four_of_a_kind
    when [3, 2]
      :full_house
    when [3, 1, 1]
      :three_of_a_kind
    when [2, 2, 1]
      :two_pair
    when [2, 1, 1, 1]
      :one_pair
    when [1, 1, 1, 1, 1]
      :high_card
    else
      raise "Invalid hand"
    end
  end

  def <=> (other)
    if type == other.type
      self.cards.each_with_index do |card, index|
        cmp = card <=> other.cards[index]
        return cmp unless cmp == 0
      end

      return 0
    else
      RANKS[type] <=> RANKS[other.type]
    end
  end

  def to_s
    @cards.map(&:label).join
  end

  def inspect
    "<Hand: #{to_s} (#{type})>"
  end
end

class Card
  include Comparable

  RANKS = {
    "A" => 14, "K" => 13, "Q" => 12, "J" => 11, "T" => 10, "9" => 9, "8" => 8,
    "7" => 7, "6" => 6, "5" => 5, "4" => 4, "3" => 3, "2" => 2
  }

  attr_reader :label

  def initialize(label)
    @label = label
  end

  def <=> (other)
    RANKS[@label] <=> RANKS[other.label]
  end

  def to_s
    @label
  end

  def inspect
    "<Card: #{@label}>"
  end
end

hands = File.read("day-07.in").split("\n").map { _1.split }.map { [Hand.new(_1), _2.to_i] }

part_1 = 0

hands.sort.each_with_index do |(hand, bid), rank|
  # pp [bid, rank + 1, hand]
  part_1 += bid * (rank + 1)
end

puts part_1

# part 2
#
# Monkey patching for the win! 🎉

class Hand
  alias_method :original_type, :type

  def type
    includes_joker = @cards.any? { _1.label == "J" }
    only_jokers = @cards.all? { _1.label == "J" }

    if includes_joker && !only_jokers
      non_joker_cards = @cards.reject { _1.label == "J" }

      possible_hands = []
      non_joker_cards.each do |card|
        possible_hands << self.replace_joker_with(card)
      end

      return possible_hands.map(&:type).max_by { |t| RANKS[t] }
    end

    original_type
  end

  def replace_joker_with(card)
    self.class.new(cards.map { |c| c.label == "J" ? card.label : c.label }.join)
  end
end

class Card
  remove_const(:RANKS)

  RANKS = {
    "A" => 14, "K" => 13, "Q" => 12, "T" => 10, "9" => 9, "8" => 8,
    "7" => 7, "6" => 6, "5" => 5, "4" => 4, "3" => 3, "2" => 2, "J" => 0
  }
end

hands = File.read("day-07.in").split("\n").map { _1.split }.map { [Hand.new(_1), _2.to_i] }

part_2 = 0

hands.sort.each_with_index do |(hand, bid), rank|
  part_2 += bid * (rank + 1)
end

puts part_2
