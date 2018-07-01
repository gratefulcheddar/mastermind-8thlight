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

        if guess.count == game.code_length
            break if game.validate_colors(guess)
            io.output game.invalid_color_error_message
        else
            io.output game.wrong_number_message(guess.count)
        end
    
    end
    
    results = game.get_results(guess)
    results[:turn] = turn
    io.output results
    
    if results[:black_pins] == game.code_length
        io.output game.winning_message
        break
    end

    if turn == game.max_turns 
        io.output game.out_of_turns_message
    end

    turn += 1

end

