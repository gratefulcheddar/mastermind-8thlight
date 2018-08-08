class MastermindDialog

  def welcome_message
    "\nWelcome to Mastermind!\n\n"
  end

  def instructions_human
    "To play: The computer will choose a combination 4 colors. The possible colors include RED, BLUE, GREEN, ORANGE, YELLOW, and PURPLE. Each color can be repeated any number of times.\n\n" + 
      "You have #{Rules::MAX_TURNS} turns to guess the correct combination. After every guess, you will be given feedback.\n\n" +
      "Black Pins signify the number of correct colors in the correct positions. White pins signify the number of correct colors in the incorrect positions. The game will also accept the following commands when prompting for a code: 'quit' will quit the game, and 'restart' will start a new game.\n\n"
  end

  def instructions_computer
    "To play: You will choose a combination of 4 colors. The possible colors include RED, BLUE, GREEN, ORANGE, YELLOW, and PURPLE. Each color can be repeated any number of times..\n\n" + 
      "The computer will then guess your combination in a maximum of #{Rules::MAX_TURNS} turns.\n\n"
  end

  def game_modes
    "There are #{Rules::GAME_MODES.count} game modes:\n" +
    "\tHuman - Human Guessing vs. a Computer Codemaster\n" +
    "\tComputer - Computer Guessing vs. a Human Codemaster\n" +
    "\tAuto - Computer vs. Computer\n\n"
  end

  def invalid_option_error_message
    "Invalid option"
  end

  def instructions_auto
    "Results:"
  end

  def restart_message
    "Would you like to play again (yes/no)?"
  end

  def mode_input_message
    "Enter #{Rules::GAME_MODES.join(', ')}"
  end

  def code_input_message
    "Enter a combination of #{Rules::SECRET_LENGTH} colors (red, blue, green, orange, yellow, or purple) separated by spaces and press Enter"
  end

  def invalid_color_error_message(invalid_colors)
    "#{pluralize(invalid_colors)}. Please guess again. \n"
  end

  def pluralize(invalid_colors)
    "#{invalid_colors} #{invalid_colors.count == 1 ? 'is not a valid color.' : 'are not valid colors.'}"
  end

  def wrong_number_message(count)
    "The combination requires #{Rules::SECRET_LENGTH} colors, your code had #{count}. Please try again.\n"
  end

  def winning_message_human
    "You win! Congratulations!\n"
  end

  def winning_message_computer
    "Computer wins!\n"
  end

  def out_of_turns_message
    "You have run out of turns! Sorry!\n"
  end
end


