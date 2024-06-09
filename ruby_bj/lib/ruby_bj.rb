require_relative "deck"
require_relative "player"
require_relative "console"

class Game

  def initialize()
    @deck = Deck.new.create.shuffle
    @dealer = Player.new("DEALER")
    @you = Player.new("YOU")
    @console = Console.new([@dealer, @you])
  end

  def start

    @console.message("Game start!")

    result = {dealer: 0, you: 0}
    @dealer.draw(@deck, 1, true)
    @dealer.draw(@deck, 1, false)
    @you.draw(@deck, 2, true)

    sleep 1
    @console.info("Dealer dealt cards.")

    if @you.score == 21 then
      sleep 1
      @console.message("You get​natural 21!")
      result[:you] = 22
    else
      loop do
        sleep 1
        puts "Would you like to draw another card? [y(hit)/n(stand)]"
        command = gets.chomp.downcase
        puts
        case command
        when "y", "yes", "hit" then
          @you.draw(@deck, 1, true)
          @console.info("YOU draw card.")
          if @you.score == 21 then
            @console.message("YOU get 21!")
            result[:you] = 21
            break
          elsif @you.score > 21 then
            @console.message("YOU bust!")
            result[:you] = -1
            break
          end
        when "n", "no", "stand" then
          @console.message("YOU stand.")
          result[:you] = @you.score
          break
        else
          @console.message("Invalid command.")
        end
      end
    end

    sleep 1
    @dealer.hole_card_open
    @console.info("Hole card open!")

    if @dealer.score == 21 then
      sleep 1
      @console.message("DEALER get natural 21!")
      result[:dealer] = 22
    else
      loop do
        sleep 1
        if @dealer.score < 17 then
          @dealer.draw(@deck, 1, true)
          @console.info("DEALER draw card.")
          if @dealer.score == 21 then
            @console.message("DEALER get 21!")
            result[:dealer] = 21
            break
          elsif @dealer.score > 21 then
            @console.message("DEALER bust!")
            result[:dealer] = 0
            break
          end
        else
          result[:dealer] = @dealer.score
          break
        end
      end
    end

    sleep 1
    if result[:dealer] == result[:you] then
      @console.message("Draw game.")
    elsif result[:dealer] < result[:you] then
      @console.message("You win!")
    else
      @console.message("You lose.")
    end

  end
end

Game.new.start