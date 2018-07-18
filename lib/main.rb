require_relative '../lib/game_controller'

loop do
  game_controller = GameController.new
  game_controller.play_game
  if game_controller.guess == [:quit]
    print "Are you sure you'd like to quit? (Enter yes or no): "
    replay = gets.chomp.downcase.to_sym
    while replay != :no && replay != :yes
      print "\nEnter yes or no: "
      replay = gets.chomp.downcase.to_sym
    end
    break if replay == :yes
  end
  print "Would you like to play again? (Enter yes or no): "
  replay = gets.chomp.downcase.to_sym
  while replay != :no && replay != :yes
    print "\nEnter yes or no: "
    replay = gets.chomp.downcase.to_sym
  end
  break if replay == :no
  puts "\nRestarting in 3 seconds..."
  sleep(3)
  system "clear" or system "cls"
end