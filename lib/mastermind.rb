class Mastermind

  attr_reader :max_turns, :code_length, :secret_code, :history

  COLOR_OPTIONS = %i[red blue green orange purple yellow].freeze

  def initialize(code_length = 4, max_turns = 10)
    @code_length = code_length
    @max_turns = max_turns
    @secret_code = new_code
    @history = []
  end

  def new_code
    Array.new(code_length) { COLOR_OPTIONS.sample }
  end

  def validate_colors(guess)
    guess.all? { |color| Mastermind::COLOR_OPTIONS.include? color }
  end

  def get_results(original_guess)
    code = @secret_code.clone
    guess = original_guess.clone

    results = { guess: original_guess, black_pins: 0, white_pins: 0 }

    code.each_index do |index|
      if guess[index] == code[index]
        results[:black_pins] += 1
        code[index] = :guessed
        guess[index] = :used
      end
    end

    guess.each do |color|
      if code.include? color 
        results[:white_pins] += 1
        code[code.index(color)] = :guessed
      end
    end

    results
  end

  def update_history(result)
    @history << result
  end
end