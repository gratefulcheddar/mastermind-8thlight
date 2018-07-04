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

    while @turn <= @game.max_turns

      @guess = @io.get_guess(@game.code_length)
    
      result = @game.get_result(@guess)
      result[:turn] = @turn
      @board.add(result)
      @io.output @board.history
    
      if result[:black_pins] == @game.code_length
        @io.output @messages.winning_message
        break
      end
    
      @io.output @messages.out_of_turns_message(@game.secret_code) if @turn == @game.max_turns
    
      @turn += 1
    end
  end

end
