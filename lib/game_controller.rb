require_relative "../lib/mastermind"
require_relative '../lib/mastermind_io'

game = Mastermind.new
io = MastermindIO.new

io.output game.instructions
turn = 1

while turn <= game.max_turns
    
    guess = []
    
    loop do
        guess = io.prompt(game.color_input_message)
        guess = guess.chomp.downcase.split(' ')
        guess.map! { |color| color.to_sym }

        if guess.count == game.code_length
            break if game.validate_colors(guess)
            puts game.invalid_color_error_message
        else
            puts game.wrong_number_message(guess.count)
        end
    
    end
    
    results = game.get_results(guess)
    results[:turn] = turn
    puts results
    
    if results[:black_pins] == game.code_length
        puts game.winning_message
        break
    end

    if turn == game.max_turns 
        puts game.out_of_turns_message
    end

    turn += 1

end

