require_relative '../lib/board'

class Mastermind
  attr_reader :max_turns, :code_length, :secret_code, :board, :messages

  COLOR_OPTIONS = %i[red blue green orange purple yellow].freeze
  GAME_OPTIONS = %i[quit restart].freeze

  def initialize(code_length: 4, max_turns: 10, board: Board.new)
    @code_length = code_length
    @max_turns = max_turns
    @secret_code = new_code
    @board = board
  end

  def new_code
    Array.new(code_length) { COLOR_OPTIONS.sample }
  end

  def self.validate_colors(guess)
    guess.all? { |color| Mastermind::COLOR_OPTIONS.include? color }
  end

  def get_result(secret_code, original_guess)
    code = secret_code.clone
    guess = original_guess.clone

    result = { guess: original_guess, black_pins: 0, white_pins: 0 }

    add_black_pins_to_result(code, guess, result)
    add_white_pins_to_result(code, guess, result)

    result
  end

  def add_black_pins_to_result(code, guess, result)
    code.each_index do |index|
      if guess[index] == code[index]
        result[:black_pins] += 1
        code[index] = :guessed
        guess[index] = :used
      end
    end
  end

  def add_white_pins_to_result(code, guess, result)
    guess.each do |color|
      if code.include? color 
        result[:white_pins] += 1
        code[code.index(color)] = :guessed
      end
    end
  end

  def add_to_board(result)
    @board.add(result)
  end
end
