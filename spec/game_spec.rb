require 'game'

RSpec.describe 'HumanGuessGame' do
  describe '#play' do
    it 'plays through a game with human guessing' do
      game = Game.for(:human)
      allow($stdout).to receive(:puts)
      allow($stdout).to receive(:print)
      allow($stdin).to receive(:gets).and_return('red red red red')
      game.play
      expect(game.status).to eq(:won).or(eq(:lost))
      expect(game.board.turn_count).to be <= Rules::MAX_TURNS
    end
  end
end

RSpec.describe 'ComputerGuessGame' do
  describe '#play' do
    it 'computer wins within max turns' do
      game = Game.for(:computer)
      allow($stdout).to receive(:puts)
      allow($stdout).to receive(:print)
      allow($stdin).to receive(:gets).and_return('red green yellow blue')
      game.play
      expect(game.status).to eq :won
      expect(game.board.turn_count).to be <= Rules::MAX_TURNS
    end
  end
end

RSpec.describe 'AutoGuessGame' do
  describe '#play' do
    it 'computer win within max turns' do
      game = Game.for(:auto)
      allow($stdout).to receive(:puts)
      game.play
      expect(game.status).to eq :won
      expect(game.board.turn_count).to be <= Rules::MAX_TURNS
    end
  end
end