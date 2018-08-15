require 'turn'

class Board
  attr_reader :turns, :secret_code

  def initialize
    @turns = []
    @secret_code = nil
  end

  def add_secret(code)
    @secret_code = code
  end

  def add_guess(guess)
    new_turn = Turn.with(guess)
    @turns.append(new_turn)
  end

  def add_feedback(pins)
    @turns.last.feedback = pins
  end

  def won?
    last_pins == [Rules::SECRET_LENGTH,0]
  end

  def empty?
    turns.empty?
  end

  def last_pins
    last_turn.feedback
  end

  def last_guess
    last_turn.guess
  end

  def turn_count
    turns.count
  end

private

  def last_turn
    @turns.last
  end

  def to_s
    board_string = "\n"
    @turns.each do |turn|

      board_string << turn.to_s

    end
    board_string << "\n"
    board_string
  end
end