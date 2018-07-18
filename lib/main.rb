require_relative '../lib/game_controller'

loop do
  game_controller = GameController.new
  game_controller.play_game
  break if game_controller.guess == [:quit]
  system "clear" or system "cls"
end