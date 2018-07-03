class Board
  attr_reader :history

  def initialize
    @history = []
  end

  def add(guess)
    @history << guess
  end
end