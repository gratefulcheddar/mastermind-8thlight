require 'player'

RSpec.describe 'HumanPlayer' do

  let(:board) { Board.new }
  let(:player) { HumanPlayer.new(board, MastermindIOHuman.new) }

  describe '#add_secret_to_board(override)' do
    context 'when no parameter is specified' do
      it 'adds the secret code from stdin to the board' do
        allow($stdout).to receive(:print)
        allow($stdin).to receive(:gets).and_return('blue blue blue blue')
        player.add_secret_to_board
        expect(board.secret_code).to eq %i[blue blue blue blue]
      end
    end

    context 'when a parameter is specified' do
      it 'adds the parameter to the board' do
        player.add_secret_to_board(%i[blue blue blue green])
        expect(board.secret_code).to eq %i[blue blue blue green]
      end
    end
  end

  describe '#add_guess_to_board' do
    it 'adds guess from stdin to board' do
      allow($stdout).to receive(:print)
      allow($stdin).to receive(:gets).and_return('red red red red')
      player.add_guess_to_board
      expect(board.last_guess).to eq %i[red red red red]
    end
  end

  describe '#add_feedback_to_board' do
    it 'adds feedback pins to the board based on the last guess' do
      allow($stdout).to receive(:print)
      allow($stdin).to receive(:gets).and_return('blue blue blue blue')
      player.add_guess_to_board
      player.add_secret_to_board(%i[blue blue blue blue])
      player.add_feedback_to_board
      expect(board.last_pins).to eq [4,0]
    end
  end

  describe '#calculate_pin_feedback(secret_code, guess_code)' do
    context 'when passed parameters' do
      it 'returns [2,0] when comparing [red red red red] to [red red blue blue]' do
        secret_code = %i[red red red red]
        guess_code = %i[red red blue blue]
        expect(player.calculate_pin_feedback(secret_code, guess_code)).to eq [2,0]
      end
    end

    context 'when passed no parameters' do
      it 'uses the secret code and last guess on board' do
        allow($stdout).to receive(:print)
        allow($stdin).to receive(:gets).and_return('red red red red')
        player.add_secret_to_board(%i[red red blue blue])
        player.add_guess_to_board
        expect(player.calculate_pin_feedback).to eq [2,0]
      end
    end
  end
end

RSpec.describe 'ComputerPlayer' do
  let(:board) { Board.new }
  let(:player) { ComputerPlayer.new(board, MastermindIOComputer.new) }

  describe '#add_guess_to_board' do
    context 'when the board is empty' do
      it 'guesses red, red, blue, blue' do
        player.add_guess_to_board
        expect(board.last_guess).to eq %i[red red blue blue]
      end
    end

    context 'when the board is not empty' do
      it 'adds a random guess to the board based on the current board state (past guesses and feedback)' do
        player.add_secret_to_board(%i[purple purple purple purple])
        player.add_guess_to_board
        player.add_feedback_to_board
        player.add_guess_to_board
        expect(board.last_guess).not_to eq %i[red red blue blue]
      end
    end
  end
end
