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
  def initialize(printer: Printer.new, getter: Getter.new)
    if printer.respond_to?(:puts) and printer.respond_to?(:print)
      @printer = printer
    else
      raise NoMethodError, "Printer: #{printer} must respond to .puts and .print"
    end

    if getter.respond_to?(:gets)
      @getter = getter
    else
      raise NoMethodError, "Getter: #{getter} must respond to .gets"
    end

    @messages = MastermindDialog.new
  end

  def output(message)
    @printer.puts(message)
  end

  def prompt(message)
    @printer.print("#{message}: ")
    @getter.gets.chomp
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
        output @messages.invalid_color_error_message
      else
        output @messages.wrong_number_message(guess.count)
      end
    end
  end
end

