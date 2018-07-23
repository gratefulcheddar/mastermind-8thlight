class MastermindDialog

  def welcome_message
    "\nWelcome to Mastermind!\n\n"
  end

  def game_mode_message
    "Please enter a game mode (1 for Human Guessing, 2 for Computer Guessing): "
  end

  def instructions
    "To play: The computer will choose a secret code comprised of 4 colors. The possible colors include RED, BLUE, GREEN, ORANGE, YELLOW, and PURPLE. The computer can choose any combination of colors, and they can be repeated.\n\n" + 
      "You will then take turns guessing the #{Mastermind::SECRET_LENGTH} color sequence. If you do not guess the correct pattern within #{Mastermind::MAX_TURNS} attempts, you lose. After each guess round, you will be given two numbers as feedback, the number of correct colors in correct places, and the number of correct colors in incorrect places.\n\n" +
      "During the guessing round, you will be able to enter input into the command line. The game will accept the correct spelling of each color, regardless of capitalization. It will also accept a few navigational commands: 'quit' which will quit the game, and 'restart' which starts a new game.\n\n"
  end

  def instructions_2
    "To play: The computer will choose a secret code comprised of 4 colors. The possible colors include RED, BLUE, GREEN, ORANGE, YELLOW, and PURPLE. The computer can choose any combination of colors, and they can be repeated.\n\n" + 
      "You will then take turns guessing the #{Mastermind::SECRET_LENGTH} color sequence. If you do not guess the correct pattern within #{Mastermind::MAX_TURNS} attempts, you lose. After each guess round, you will be given two numbers as feedback, the number of correct colors in correct places, and the number of correct colors in incorrect places.\n\n" +
      "During the guessing round, you will be able to enter input into the command line. The game will accept the correct spelling of each color, regardless of capitalization. It will also accept a few navigational commands: 'quit' which will quit the game, and 'restart' which starts a new game.\n\n"
  end

  def color_input_message
    "Create a code with #{Mastermind::SECRET_LENGTH} colors (red, blue, green, orange, yellow, or purple) separated by spaces and press Enter"
  end

  def invalid_color_error_message(invalid_colors)
    "#{invalid_colors} #{invalid_colors.count == 1 ? 'is not a valid color' : 'are not valid colors'}. Please guess again. \n"
  end

  def wrong_number_message(count)
    "The secret code requires #{Mastermind::SECRET_LENGTH} colors, your code had #{count}. Please try again.\n"
  end

  def winning_message_human
    "You win! Congratulations!\n"
  end

  def winning_message_computer
    "Computer wins!\n"
  end

  def out_of_turns_message(code)
    "You have run out of turns! Sorry!\n" + "The correct code was #{code}\n"
  end

end
