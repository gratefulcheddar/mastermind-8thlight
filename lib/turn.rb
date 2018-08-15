class Turn
  attr_accessor :feedback
  attr_reader :guess

  def self.with(guess)
    Turn.new(guess)
  end

  def initialize(guess)
    @guess = guess
    @feedback = []
  end

  def to_s
    "Black Pins: #{@feedback[0]} | White Pins: #{@feedback[1]} | Guess: #{@guess}\n"
  end
end