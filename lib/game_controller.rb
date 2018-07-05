require_relative "../lib/mastermind"
require_relative '../lib/mastermind_dialog'

class GameController
  def initialize()
    @game = Mastermind.new
    @turn = 1
    @guess = []
    @messages = MastermindDialog.new
    @board = @game.board
  end

  def play_game
    puts @messages.instructions

    while @turn <= @game.max_turns
      print @messages.color_input_message

      loop do
        @guess = gets.chomp.downcase.split(' ')
        @guess.map! { |color| color.to_sym }
    
        if @guess.count == @game.code_length
          break if @game.validate_colors(@guess)
          puts @messages.invalid_color_error_message
        else
          puts @messages.wrong_number_message(@guess.count)
        end
      end
    
      result = @game.get_results(@guess)
      result[:turn] = @turn
      @board.add(result)
      puts @board.history
    
      if result[:black_pins] == @game.code_length
        puts @messages.winning_message
        break
      end
    
      puts @messages.out_of_turns_message if @turn == @game.max_turns
    
      @turn += 1
    end
  end
end
