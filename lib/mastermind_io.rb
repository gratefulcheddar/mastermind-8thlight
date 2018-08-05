require_relative '../lib/mastermind_dialog'
require_relative '../lib/rules'

class Printer
  def puts(message)
    $stdout.puts message
  end

  def print(message)
    $stdout.print message
  end
end

class Getter
  def gets
    $stdin.gets
  end
end

class MastermindIO
  def initialize(printer: Printer.new, getter: Getter.new, messages: MastermindDialog)
    @printer = printer
    @getter = getter
    @messages = messages.new
  end

  def output(message)
    @printer.puts(message)
  end

  def prompt(message)
    @printer.print("#{message}: ")
    @getter.gets.chomp
  end

  def print(message)
    @printer.print(message)
  end
  
  def get_code
    loop do
      user_input = prompt_for_code
      formatted_guess = user_input.downcase.split(' ').map(&:to_sym)

      return formatted_guess if validate(formatted_guess)

      if formatted_guess == [:quit]
        abort
      elsif formatted_guess == [:restart]
        exec('ruby lib/main.rb')
      else
        input_error(formatted_guess)
      end
    end
  end

  def get_game_mode
    output @messages.game_modes
    loop do
      user_input = prompt_for_game_mode
      game_mode = user_input.downcase.to_sym
      return game_mode if Rules::GAME_MODES.include? game_mode
      output @messages.invalid_option_error_message
    end
  end

  def lose
    output @messages.out_of_turns_message
  end

  def win
    output @messages.winning_message_computer
  end

  def welcome
    output @messages.welcome_message
  end

  def restart
    exec('ruby lib/main.rb') if restart?
  end

private
  def prompt_for_code
    prompt(@messages.code_input_message)
  end

  def validate(guess)
    guess.count == Rules::SECRET_LENGTH && 
    guess.all? { |color_symbol| Rules::COLOR_OPTIONS.include? color_symbol }
  end

  def input_error(guess)
    if guess.count != Rules::SECRET_LENGTH
      output @messages.wrong_number_message(guess.count)
    else
      invalid_options = guess.reject { |option| Rules::COLOR_OPTIONS.include? option }
      output @messages.invalid_color_error_message(invalid_options)
    end
  end

  def prompt_for_game_mode
    prompt(@messages.mode_input_message)
  end

  def restart?
    loop do
      user_input = prompt_for_restart
      restart = user_input.downcase.to_sym
      return true if restart == :yes
      return false if restart == :no
      output @messages.invalid_option_error_message
    end
  end

  def prompt_for_restart
    prompt(@messages.restart_message)
  end

end

class MastermindIOHuman < MastermindIO
  def win 
    output @messages.winning_message_human
  end

  def display_instructions
    output @messages.instructions_human
  end
end

class MastermindIOComputer < MastermindIO

  def display_instructions
    output @messages.instructions_computer
  end
end

class MastermindIOAuto < MastermindIO
  def display_instructions
    output @messages.instructions_auto
  end
end