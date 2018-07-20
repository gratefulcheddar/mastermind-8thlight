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

    Mastermind::MAX_TURNS.times do

      @guess = @io.get_guess(Mastermind::SECRET_LENGTH)

      break if @guess == [:restart] || @guess == [:quit]

      result = @game.get_result(@game.secret_code, @guess)
      @game.add_to_board(result)
      @io.output @game.board

      if @game.winning_condition?
        @io.output @messages.winning_message
        break
      end

      if @game.out_of_turns?
        @io.output @messages.out_of_turns_message(@game.secret_code)
        break
      end

    end
  end

  def play_game_2
    @io.output @messages.instructions

    @game.secret_code = @io.get_guess(Mastermind::SECRET_LENGTH)

    new_combinations = Mastermind::COLOR_OPTIONS.repeated_permutation(4).to_a

    (1..Mastermind::MAX_TURNS).each do |turn_number|

      possible_combinations = new_combinations
      new_combinations = []

      computer_guess = possible_combinations.sample

      result = @game.get_result(@game.secret_code, computer_guess)
      result[:turn] = turn_number
      @game.add_to_board(result)

      pins = [result[:black_pins], result[:white_pins]]

      if result[:black_pins] == Mastermind::SECRET_LENGTH
        @io.output @messages.winning_message
        break
      end

      if turn_number == Mastermind::MAX_TURNS
        @io.output @messages.out_of_turns_message(@game.secret_code)
        break
      end

      possible_combinations.each do |combination|
        test_result = @game.get_result(combination, computer_guess)
        test_pins = [test_result[:black_pins], test_result[:white_pins]]
        new_combinations << combination if test_pins == pins
      end
    end

    @io.output @game.board
  end
end
