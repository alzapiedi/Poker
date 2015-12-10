class Hand
  RANK_STRING = { 1 => "High Card", 2 => "Pair", 3 => "Two Pairs", 4 => "Three of a Kind", 5 => "Straight", 6 => "Flush", 7=> "Full House", 8 => "Four of a Kind", 9 => "Straight Flush", 10 => "Royal Flush!" }

  attr_reader :cards, :card_values, :card_suits, :counts
  def self.deal_from(deck)
    Hand.new(deck.take(5))
  end

  def initialize(cards)
    @cards = cards
    update_hand
  end

  def update_hand
    @card_values = @cards.map { |card| card.rank }.sort.reverse
    if @card_values == [14,5,4,3,2]
      @card_values = [5,4,3,2,1]
    end
    @card_suits = @cards.map { |card| card.suit }
    @counts = Hash.new(0)
    @card_values.each { |value| @counts[value] += 1 }
  end

  def to_s
    arr = []
    cards.each do |card|
      arr << card.to_s
    end
    "[ #{arr.join(", ")} ], #{RANK_STRING[hand_rank]}"
  end

  def compare_by_count(hand2, n)
    hand1ranks = counts.select { |_, count| count == n }.keys.sort.reverse
    hand2ranks = hand2.counts.select { |_, count| count == n }.keys.sort.reverse
    hand1ranks.each_index do |i|
      return true if hand1ranks[i] > hand2ranks[i]
      return false if hand1ranks[i] < hand2ranks[i]
    end
    nil
  end

  def beats?(hand2)
    return true if hand_rank > hand2.hand_rank
    return false if hand_rank < hand2.hand_rank
    tests = counts.values.uniq.sort.reverse
    tests.each do |n|
      return compare_by_count(hand2, n)
    end
  end

  def straight_flush?
    straight? && flush?
  end

  def four_kind?
    counts.any? { |_, count| count == 4 }
  end

  def full_house?
    card_values.uniq.length == 2 && card_values.sort[1..3].uniq.length == 2
  end

  def flush?
    card_suits.uniq.count == 1
  end

  def straight?
    (card_values.sort.last - card_values.sort.first == 4 && card_values.uniq.sort == card_values.sort)
  end

  def three_kind?
    counts.any? { |_, count| count == 3 } && !full_house?
  end

  def two_pair?
    counts.select { |_, count| count == 2 }.length == 2
  end

  def pair?
    card_values.uniq.length == 4
  end

  def high_card?
    card_values.uniq.length == 5 && !straight? && !flush?
  end

  def hand_rank
    if straight? && flush?
      card_values.max == 14 ? 10 : 9
    elsif four_kind?
      8
    elsif full_house?
      7
    elsif flush?
      6
    elsif straight?
      5
    elsif three_kind?
      4
    elsif two_pair?
      3
    elsif pair?
      2
    elsif high_card?
      1
    end
  end

end
