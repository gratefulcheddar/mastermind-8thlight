require_relative './mastermind_io'
require_relative './mastermind_dialog'
require_relative './board'
require_relative './rules'

class Player
  attr_reader :guess

  def initialize(board, io)
    @guess = ''
    @io = io
    @board = board
  end

  def add_feedback_to_board
    pins = calculate_pin_feedback
    @board.add_feedback(pins)
  end

  def calculate_pin_feedback(secret_code = nil, guess_code = nil)
    code = (secret_code || @board.secret_code).clone
    guess = (guess_code || @board.last_guess).clone
    black_pins = 0
    code.each_index do |index|
      if guess[index] == code[index]
        black_pins += 1
        code[index] = :guessed
        guess[index] = :used
      end
    end
    white_pins = 0
    guess.each do |color|
      if code.include? color 
        white_pins += 1
        code[code.index(color)] = :guessed
      end
    end
    [black_pins, white_pins]
  end

  def view_board; end
end

class HumanPlayer < Player
  def add_secret_to_board(override = nil)
    code = override || @io.get_code
    @board.add_secret(code)
  end

  def add_guess_to_board
    code = @io.get_code
    @board.add_guess(code)
  end

  def view_board
    @io.output @board
  end
end

class ComputerPlayer < Player 
  def initialize(board, io)
    super
    @possible_combinations = Rules::COLOR_OPTIONS.repeated_permutation(Rules::SECRET_LENGTH).to_a
  end

  def add_secret_to_board(override = nil)
    code = override || Rules::COLOR_OPTIONS.sample(Rules::SECRET_LENGTH)
    @board.add_secret(code)
  end

  def add_guess_to_board
    if @board.empty?
      code = [:red, :red, :blue, :blue]
    else
      calculate_new_combinations
      code = @possible_combinations.sample
    end
    @board.add_guess(code)
  end

  private 

  def calculate_new_combinations
    previous_guess_pins = @board.last_pins
    new_combinations = @possible_combinations.map do |combination|
      combination if calculate_pin_feedback(combination, @board.last_guess) == previous_guess_pins
    end
    @possible_combinations = new_combinations.compact
  end
end