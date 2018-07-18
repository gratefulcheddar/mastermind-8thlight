require_relative "../lib/mastermind"
require_relative '../lib/mastermind_io'

class GameController

  attr_reader :guess

  def initialize(game: Mastermind.new, messages: MastermindDialog.new, io: MastermindIO.new)
    @game = game
    @guess = []
    @messages = messages
    @io = io
  end

  def play_game
    @io.output @messages.instructions

    (1..@game.max_turns).each do |turn_number|

      @guess = @io.get_guess(Mastermind::SECRET_LENGTH)

      break if @guess == [:restart] || @guess == [:quit]

      result = @game.get_result(@game.secret_code, @guess)
      result[:turn] = turn_number
      @game.add_to_board(result)
      @io.output @game.board

      if result[:black_pins] == Mastermind::SECRET_LENGTH
        @io.output @messages.winning_message
        break
      end

      if turn_number == @game.max_turns
        @io.output @messages.out_of_turns_message(@game.secret_code)
        break
      end

    end
  end
end
