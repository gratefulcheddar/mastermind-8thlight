require_relative "../lib/mastermind"

game = Mastermind.new

puts game.instructions
turn = 1

while turn <= game.max_turns

  puts game.color_input_message

  guess = []

  loop do
    guess = gets.chomp.downcase.split(' ')
    guess.map! { |color| color.to_sym }

    if guess.count == game.code_length
      break if game.validate_colors(guess)
      puts game.invalid_color_error_message
    else
      puts game.wrong_number_message(guess.count)
    end
  end

  result = game.get_results(guess)
  result[:turn] = turn
  game.update_history(result)
  puts game.history

  if result[:black_pins] == game.code_length
    puts game.winning_message
    break
  end

  puts game.out_of_turns_message if turn == game.max_turns

  turn += 1
end
