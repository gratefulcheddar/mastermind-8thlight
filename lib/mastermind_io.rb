require_relative '../lib/mastermind_dialog'
require_relative '../lib/mastermind'

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
  def initialize(printer: Printer.new, getter: Getter.new, messages: MastermindDialog.new)
    @printer = printer
    @getter = getter
    @messages = messages
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

  def get_guess(correct_length)
    loop do
      guess = prompt(@messages.color_input_message)
      guess = guess.downcase.split(' ').map!(&:to_sym)

      if guess.count == 1
        return guess if Mastermind::GAME_OPTIONS.include? guess[0]
      end

      if guess.count == correct_length
        return guess if Mastermind.validate_colors(guess)
        invalid_colors = guess.reject { |color| Mastermind::COLOR_OPTIONS.include? color}
        invalid_colors.map!(&:to_sym)
        output @messages.invalid_color_error_message(invalid_colors)
      else
        output @messages.wrong_number_message(guess.count)
      end
    end
  end

  def self.get_yes_no_answer
    answer = gets.chomp.downcase.to_sym
    while answer != :no && answer != :yes
      print "\nInvalid Input: Enter yes or no: "
      answer = gets.chomp.downcase.to_sym
    end
    answer
  end

  def self.get_game_mode
    game_mode = gets.chomp
    while game_mode != '1' && game_mode != '2'
      print "\nInvalid Input: Enter 1 or 2: "
      game_mode = gets.chomp
    end
    game_mode
  end

end
