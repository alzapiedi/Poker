require_relative 'deck'
require_relative 'hand'
suit_hash = { "H" => :hearts, "C" => :clubs, "S" => :spades, "D" => :diamonds }

value_hash = { "2" => :deuce, "3" => :three, "4" => :four, "5" => :five, "6" => :six, "7" => :seven, "8" => :eight, "9" => :nine, "T" => :ten, "J" => :jack, "Q" => :queen, "K" => :king, "A" => :ace }


######################
########EULER#########
######################

hands = []
player1 = []
player2 = []
player1hands = []
player2hands = []
File.foreach("poker0.txt") do |line|
  hands << line.chomp
end

hands = hands.map { |hand| hand.split(" ") }
hands.each do |hand|
  player1 << hand[0..4]
  player2 << hand[5..-1]
end

player1.each do |hand|
  cards = []
  hand.each do |card|
    cards << Card.new(suit_hash[card[1]], value_hash[card[0]])
  end
  player1hands << Hand.new(cards)
end
player2.each do |hand|
  cards = []
  hand.each do |card|
    cards << Card.new(suit_hash[card[1]], value_hash[card[0]])
  end
  player2hands << Hand.new(cards)
end

i = 0
ties = 0
p1 = 0
p2 = 0
while i < player1hands.length
  rank1 = player1hands[i].hand_rank
  rank2 = player2hands[i].hand_rank
  if player1hands[i].beats?(player2hands[i]).nil?
    ties += 1
  elsif player1hands[i].beats?(player2hands[i])
    p1 += 1
  else
    p2 += 1
  end
      print "#{player1hands[i].to_s}\n"
      print "#{player2hands[i].to_s}\n"
  i += 1
end
p "p1 #{p1} wins   -   p2 #{p2} wins    -    ties #{ties}"
