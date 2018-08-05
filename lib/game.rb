require_relative './player'
require_relative './board'
require_relative './mastermind_io'

class Game
  attr_reader :status, :board

  def initialize
    @board = Board.new
    @status = :new
  end

  def self.for(guesser)
    guesser = guesser.to_s.capitalize
    const_get("#{guesser}GuessGame").new
  end

  def play
    @io.display_instructions
    @code_master.add_secret_to_board

    Rules::MAX_TURNS.times do
      @code_guesser.add_guess_to_board
      @code_master.add_feedback_to_board
      break if @board.won?
      @code_guesser.view_board
    end

    @io.output @board

    if @board.won?
      @io.win
      @status = :won
    else
      @io.lose
      @status = :lost
    end
  end

  def finish_turn; end
end

class HumanGuessGame < Game
  def initialize
    super
    @io = MastermindIOHuman.new
    @code_master = ComputerPlayer.new(@board, @io)
    @code_guesser = HumanPlayer.new(@board, @io)
  end
end

class ComputerGuessGame < Game
  def initialize
    super
    @io = MastermindIOComputer.new
    @code_master = HumanPlayer.new(@board, @io)
    @code_guesser = ComputerPlayer.new(@board, @io)
  end
end

class AutoGuessGame < Game
  def initialize
    super
    @io = MastermindIOAuto.new
    @code_master = ComputerPlayer.new(@board, @io)
    @code_guesser = ComputerPlayer.new(@board, @io)
  end
end