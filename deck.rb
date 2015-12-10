require_relative 'card'
class Deck
  def self.all_cards
    deck = []
      Card.suits.each do |suit|
        Card.values.each do |value|
          deck << Card.new(suit, value)
        end
      end
    deck
  end

  def removes
    @cards.pop
  end

  def shuffle
    @cards.shuffle!
  end

  def initialize(deck = Deck.all_cards)
    @cards = deck
  end

  def count
    @cards.count
  end

  def take(n)
    raise "not enough cards" if n > @cards.count
    result = []
    n.times { result << @cards.shift}
    result
  end

  def return(return_cards)
    return_cards.each { |card| @cards << card }
  end
end
