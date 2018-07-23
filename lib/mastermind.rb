require_relative '../lib/board'

class Mastermind
  attr_reader :board
  attr_accessor :secret_code

  COLOR_OPTIONS = %i[red blue green orange purple yellow].freeze
  GAME_OPTIONS = %i[quit restart].freeze
  SECRET_LENGTH = 4
  MAX_TURNS = 10

  def initialize(board: Board.new)
    @secret_code = new_code
    @board = board
    @turn = 1
  end

  def new_code
    COLOR_OPTIONS.sample(SECRET_LENGTH)
  end

  def self.validate_colors(guess)
    guess.all? { |color| Mastermind::COLOR_OPTIONS.include? color }
  end

  def increment_turn_number
    @turn += 1
  end

  def winning_condition?
    @result[:black_pins] == SECRET_LENGTH
  end

  def out_of_turns?
    @turn > MAX_TURNS 
  end

  def finish_turn(guess)
    add_to_board(get_result(@secret_code, guess))
  end

  def get_result(secret_code, original_guess)
    code = secret_code.clone
    guess = original_guess.clone

    @result = { guess: original_guess, black_pins: 0, white_pins: 0, turn: @turn }
    increment_turn_number

    black_pins = calculate_black_pins(code, guess)
    white_pins = calculate_white_pins(code, guess)

    add_black_pins_to_result(black_pins)
    add_white_pins_to_result(white_pins)

    @result
  end

  def calculate_black_pins(code, guess)
    black_pins = 0
    code.each_index do |index|
      if guess[index] == code[index]
        black_pins += 1
        code[index] = :guessed
        guess[index] = :used
      end
    end
    black_pins
  end

  def add_black_pins_to_result(black_pins)
    @result[:black_pins] = black_pins
  end

  def calculate_white_pins(code, guess)
    white_pins = 0
    guess.each do |color|
      if code.include? color 
        white_pins += 1
        code[code.index(color)] = :guessed
      end
    end
    white_pins
  end

  def add_white_pins_to_result(white_pins)
    @result[:white_pins] = white_pins
  end

  def add_to_board(result)
    @board.add(result)
  end
end
