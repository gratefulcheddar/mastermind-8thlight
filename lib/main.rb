require_relative '../lib/game_controller'

loop do
  messages = MastermindDialog.new
  io = MastermindIO.new
  io.print(messages.game_mode_message)
  option = MastermindIO.get_game_mode
  game_controller = GameController.new
  if option == '1'
    game_controller.play_game
    if game_controller.guess == [:quit]
      print "Are you sure you'd like to quit? (Enter yes or no): "
      replay = MastermindIO.get_yes_no_answer
      break if replay == :yes
    end
  else
    game_controller.play_game_2
  end
  print "Would you like to play again? (Enter yes or no): "
  replay = MastermindIO.get_yes_no_answer
  break if replay == :no
  puts "\nRestarting in 3 seconds..."
  sleep(3)
  system "clear" or system "cls"
end