class Console
  def initialize(players)
    @players = players
  end

  def message(text)
    puts text
    puts
  end

  def info(text)
    puts text
    @players.each do |player|
      puts line(player.name)
      puts "hand: #{hand(player.hand)}"
      puts "score: #{player.score}"
      puts line
    end
    puts
  end

  private

    def line(name = "")
      result = name.to_s
      line_length = 64 - name.length
      line_length.times {result += "-"}
      result
    end

    def hand(player_hand)
      player_hand.map do |card|
        card.is_open ? "#{convert_mark(card.suit)} #{card.rank}" : "???"
      end
    end

    def convert_mark(suit)
      {spades: "♠", hearts: "♥", diams: "♦", clubs: "♣"}[suit.to_sym] || suit
    end
end