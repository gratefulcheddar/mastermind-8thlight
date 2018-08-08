require_relative './game'

class GameController
  def self.launch_game
    io = MastermindIO.new
    io.welcome
    game_mode = io.get_game_mode
    Game.for(game_mode).play
    io.restart
  end
end
