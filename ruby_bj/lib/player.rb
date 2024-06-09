class Player
  attr_reader :name, :hand

  def initialize(name)
    @name  = name
    @hand  = Array.new
  end

  def score
    score = 0
    num_of_ace = 0
    @hand.each do |card|
      next unless card.is_open
      case card.rank
      when "A" then
        num_of_ace += 1
      when "J", "Q", "K" then
        score += 10
      else
        score += card.rank.to_i
      end
    end
    num_of_ace.times do
      score += score <= 10 ? 11 : 1
    end
    score
  end

  def draw(deck, i, is_open)
    i.times do
      draw_card = deck.shift
      draw_card.is_open=(is_open)
      @hand << draw_card
    end
  end

  def hole_card_open
    @hand.each { |card| card.is_open=(true) }
  end
end