require 'board'

RSpec.describe "Board" do

  let(:game_board) { Board.new }

  describe '#add_secret(code)' do
    it 'adds the secret code to the board' do
      code = %i[red red red red]
      game_board.add_secret(code)
      expect(game_board.secret_code).to eq code
    end
  end

  describe '#add_guess(guess)' do
    it 'adds a turn to the board with specified guess and no feedback' do
      code = %i[red red red red]
      expect(game_board.turn_count).to eq 0
      game_board.add_guess(code)
      expect(game_board.turn_count).to eq 1
      expect(game_board.last_guess).to eq code
      expect(game_board.last_pins).to eq []
    end
  end

  describe '#add_feedback(pins)' do
    context 'if a guess has already been added the board' do
      it 'adds the feedback pins to the last turn' do
        code = %i[red red red red]
        pins = [1,2]
        expect(game_board.turn_count).to eq 0
        game_board.add_guess(code)
        game_board.add_feedback(pins)
        expect(game_board.turn_count).to eq 1
        expect(game_board.last_pins).to eq pins
      end
    end

    context 'if a the board is empty' do
      it 'raises an error' do
        pins = [1,2]
        expect{ game_board.add_feedback(pins) }.to raise_error(NoMethodError)
      end
    end
  end
  
  describe '#won?' do
    context 'if the last turn has enough black pins' do
      it 'returns true' do
        game_board.add_guess(%i[red red red red])
        game_board.add_feedback([Rules::SECRET_LENGTH,0])
        expect(game_board.won?).to eq true
      end
    end

    context 'if the last turn does not have enough black pins' do
      it 'returns false' do
        game_board.add_guess(%i[red red red red])
        game_board.add_feedback([Rules::SECRET_LENGTH-1,0])
        expect(game_board.won?).to eq false
      end
    end
  end

  describe "#empty?" do
    context "if the board is blank" do
      it 'returns true' do
        expect(game_board.empty?).to eq true
      end
    end

    context 'if the board is has a guess on it' do
      it 'returns false' do
        game_board.add_guess(%i[red red red red])
        expect(game_board.empty?).to eq false
      end
    end
  end

  describe '#last_pins' do
    context 'when the last turn has feedback' do
      it "returns the last turn's pins" do
        game_board.add_guess(%i[red red red red])
        game_board.add_feedback([1,0])
        expect(game_board.last_pins).to eq [1,0]
      end
    end
    context 'when the last turn has no feedback' do
      it "returns nothing" do
        game_board.add_guess(%i[red red red red])
        expect(game_board.last_pins).to eq []
      end
    end
  end

  describe '#last_guess' do
    context 'when the board has a turn on it' do
      it "returns the last turn's guess" do
        game_board.add_guess(%i[red red red red])
        expect(game_board.last_guess).to eq %i[red red red red]
      end
    end

    context 'when the board has no turns' do
      it "raises an error if no board has no turns" do
        expect{ game_board.last_guess }.to raise_error(NoMethodError)
      end
    end
  end

end