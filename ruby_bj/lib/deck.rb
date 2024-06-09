class Deck
  SUITS = ["spades", "hearts", "diams", "clubs"]
  RANKS = [*2..10].push("J", "Q", "K", "A")

  def create
    cards =  Array.new
    SUITS.each do |suit|
      RANKS.each do |rank|
        cards << Card.new(suit, rank)
      end
    end
    cards
  end

  class Card
    attr_reader :suit, :rank
    attr_accessor :is_open

    def initialize(suit, rank)
      @suit = suit
      @rank = rank
      @is_open = false
    end
  end
end