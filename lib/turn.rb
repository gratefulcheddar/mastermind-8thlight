class Turn
  attr_reader :guess, :feedback

  def self.with(guess)
    Turn.new(guess)
  end

  def initialize(guess)
    @guess = guess
    @feedback = []
  end

  def add(feedback)
    @feedback = feedback
  end

  def to_s
    "Black Pins: #{@feedback[0]} | White Pins: #{@feedback[1]} | Guess: #{@guess}\n"
  end
end