require 'mastermind'

RSpec.describe 'Mastermind' do
  let(:new_game) { Mastermind.new }

  describe '#new_code' do
    let(:secret_code) { new_game.new_code }

    it 'has 4 colors' do
      expect(secret_code.count).to eq 4
    end

    it 'uses valid colors' do
      for color in secret_code do
        expect(Mastermind::COLOR_OPTIONS.include?(color)).to eq true
      end
    end
  end

  describe '#get_result(secret_code, original_guess)' do
    let(:test_code) { %i[red blue green yellow] }

    it 'returns 4 black pins when 4 correct colors are in the correct place' do
      test_guess = test_code
      results = new_game.get_result(test_code, test_guess)
      expect(results[:black_pins]).to eq 4
      expect(results[:white_pins]).to be_zero
    end

    it 'returns 3 black pins when 3 correct colors are in the correct place' do
      test_guess = %i[red blue green purple]
      results = new_game.get_result(test_code, test_guess)
      expect(results[:black_pins]).to eq 3
      expect(results[:white_pins]).to be_zero
    end

    it 'returns 0 black and white pins when there are no correct colors' do
      test_guess = %i[purple purple purple purple]
      results = new_game.get_result(test_code, test_guess)
      expect(results[:black_pins]).to be_zero
      expect(results[:white_pins]).to be_zero
    end

    it 'returns 2 black pins and 2 white pins when 2 correct colors are in the correct place and 2 correct colors are in the wrong place' do
      test_guess = %i[green green green yellow]
      results = new_game.get_result(test_code, test_guess)
      expect(results[:black_pins]).to eq 2
      expect(results[:white_pins]).to be_zero
    end
  end

  describe '#validate_colors(guess)' do
    it 'returns true if all guess colors are valid options' do
      test_guess = %i[red blue green yellow]
      expect(Mastermind.validate_colors(test_guess)).to eq true
    end

    it 'returns false if any of the guess colors are invalid options' do
      test_guess = %i[red blue oops yellow]
      expect(Mastermind.validate_colors(test_guess)).to eq false
    end
  end

  describe '#winning_condition?' do
    class MockMastermind < Mastermind
      attr_accessor :result
    end

    let(:mock_game) { MockMastermind.new }
    
    it 'returns true if the result has 4 black pins' do
      mock_game.result = { black_pins: Mastermind::SECRET_LENGTH }
      expect(mock_game.winning_condition?).to eq true
    end

    it 'returns false if the result has less than 4 black pins' do
      mock_game.result = { black_pins: (Mastermind::SECRET_LENGTH - 1) }
      expect(mock_game.winning_condition?).to eq false
    end

  end
end
