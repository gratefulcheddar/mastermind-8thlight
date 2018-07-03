require 'board'

RSpec.describe "Board" do

  let(:game_board) { Board.new }

  describe '#update_history(result)' do
    it 'adds turn result to the game history' do
      test_result = { guess: %i[red red red red], black_pins: 0, white_pins: 1, turn: 1 }
      game_board.add(test_result)
      expect(game_board.history).to eq [test_result]
    end

    it 'appends to existing array in the correct turn order' do
      test_result_a = { guess: %i[red red red red], black_pins: 0, white_pins: 1, turn: 1 }
      game_board.add(test_result_a)

      test_result_b = { guess: %i[blue blue red red], black_pins: 2, white_pins: 0, turn: 2 }
      game_board.add(test_result_b)
      
      expect(game_board.history).to eq [test_result_a, test_result_b]
    end
  end
end