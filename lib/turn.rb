class Turn
  attr_reader :guess, :feedback

  def self.with(guess)
    Turn.new(guess)
  end

  def add(pins)
    @feedback = pins
  end

  def to_s
    "Black Pins: #{@feedback[0]} | White Pins: #{@feedback[1]} | Guess: #{@guess}\n"
  end
  
private
  def initialize(guess)
    @guess = guess
    @feedback = []
  end
end