require_relative "../lib/mastermind"
require_relative '../lib/mastermind_dialog'
require_relative '../lib/mastermind_io'

class GameController
  def initialize()
    @game = Mastermind.new
    @turn = 1
    @guess = []
    @messages = @game.messages
    @board = @game.board
    @io = MastermindIO.new
  end

  def play_game
    @io.output @messages.instructions

    @game.max_turns.times do

      @guess = @io.get_guess(@game.code_length)

      break if @guess.count == 1
    
      result = @game.get_result(@guess)
      result[:turn] = @turn
      @board.add(result)
      @io.output @board.history
    
      if result[:black_pins] == @game.code_length
        @io.output @messages.winning_message
        break
      end
    
      if @turn == @game.max_turns
        @io.output @messages.out_of_turns_message(@game.secret_code)
        break
      end

      @turn += 1
    end
  end
end
