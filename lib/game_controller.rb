require_relative "../lib/mastermind"

game = Mastermind.new

puts game.instructions
turn = 1

while turn <= 10

    puts game.color_input_message
    
    guess = []
    
    loop do
        
        valid_input = false
        guess = gets.chomp.downcase.split(' ')
        guess.map! { |color| color.to_sym }
    
        if guess.count != 4
            puts "The secret code has 4 items, your guess had #{guess.count}. Please guess again.\n"
        elsif guess.all? { |color| Mastermind::COLOR_OPTIONS.include? color }
            valid_input = true
        else
            puts "Invalid color option entered. Please guess again.\n"
        end
    
        break if valid_input
    end
    
    results = game.get_results(guess)
    results[:turn] = turn
    puts results
    
    if results[:black_pins] == 4
        puts "You win! Congratulations!\n"
        break
    end

    if turn == 10 
        puts "You have run out of turns! Sorry!\n"
    end

    turn += 1

end

