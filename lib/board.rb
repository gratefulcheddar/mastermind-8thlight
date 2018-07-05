class Board
  attr_reader :history

  def initialize
    @history = []
  end

  def add(guess)
    @history << guess
  end

  def to_s
    board = "\n"
    @history.each do |turn|
      board << "Turn \##{turn[:turn]} Black Pins = #{turn[:black_pins]}, White Pins = #{turn[:white_pins]}, Guess = #{turn[:guess]}\n"
    end
    board << "\n"
    board
  end
end