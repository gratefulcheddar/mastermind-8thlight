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
    
        if guess.count != 4
            puts game.wrong_number_of_items(guess.count)
        elsif game.validate_guess_colors(guess)
            break
        else
            puts game.invalid_color_error_message
        end
    end
    
    results = game.get_results(guess)
    results[:turn] = turn
    puts results
    
    if results[:black_pins] == 4
        puts game.winning_message
        break
    end

    if turn == 10 
        puts game.out_of_turns_message
    end

    turn += 1

end

