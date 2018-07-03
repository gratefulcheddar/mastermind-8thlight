class Mastermind

  attr_reader :max_turns, :code_length, :secret_code, :history

  COLOR_OPTIONS = %i[red blue green orange purple yellow].freeze

  def initialize(code_length = 4, max_turns = 10)
    @code_length = code_length
    @max_turns = max_turns
    @secret_code = new_code
    @history = []
  end

  def instructions
    "Welcome to Mastermind!\n\n" + 
      "To play: The computer will choose a secret code comprised of 4 colors. The possible colors include RED, BLUE, GREEN, ORANGE, YELLOW, and PURPLE. The computer can choose any combination of colors, and they can be repeated.\n\n" + 
      "You will then take turns guessing the 4 color sequence. If you do not guess the correct pattern within 10 attempts, you lose. After each guess round, you will be given two numbers as feedback, the number of correct colors in correct places, and the number of correct colors in incorrect places.\n\n" +
      "During the guessing round, you will be able to enter input into the command line. The game will accept the correct spelling of each color, regardless of capitalization. It will also accept a few navigational commands: !quit which will quit the game after confirmation, and !restart which starts a new game after confirmation\n\n"
  end

  def color_input_message
    "Guess 4 colors separated by spaces and press Enter.\n Your choices include red, blue, green, orange, purple, yellow and each color can be repeated any number of times.\n"
  end

  def invalid_color_error_message
    "Invalid color option entered. Please guess again.\n"
  end

  def wrong_number_message(count)
    "The secret code has 4 items, your guess had #{count}. Please guess again.\n"
  end

  def winning_message
    "You win! Congratulations!\n"
  end

  def out_of_turns_message
    "You have run out of turns! Sorry!\n" + "The correct code was #{secret_code}\n"
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