class MastermindDialog

  def instructions
    "\nWelcome to Mastermind!\n\n" + 
      "To play: The computer will choose a secret code comprised of 4 colors. The possible colors include RED, BLUE, GREEN, ORANGE, YELLOW, and PURPLE. The computer can choose any combination of colors, and they can be repeated.\n\n" + 
      "You will then take turns guessing the 4 color sequence. If you do not guess the correct pattern within 10 attempts, you lose. After each guess round, you will be given two numbers as feedback, the number of correct colors in correct places, and the number of correct colors in incorrect places.\n\n" +
      "During the guessing round, you will be able to enter input into the command line. The game will accept the correct spelling of each color, regardless of capitalization. It will also accept a few navigational commands: 'quit' which will quit the game, and 'restart' which starts a new game.\n\n"
  end

  def color_input_message
    "Guess 4 colors (red, blue, green, orange, yellow, or purple) separated by spaces and press Enter"
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

  def out_of_turns_message(code)
    "You have run out of turns! Sorry!\n" + "The correct code was #{code}\n"
  end

end
