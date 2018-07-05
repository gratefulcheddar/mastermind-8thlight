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
        expect(Mastermind::COLOR_OPTIONS.include? color).to eq true
      end
    end
  end

  describe '#get_result(guess)' do

    class MockMastermind < Mastermind
      attr_accessor :secret_code
    end

    let(:mock_game) { MockMastermind.new }

    before(:each) do
      mock_game.secret_code = %i[red blue green yellow]
    end

    it 'returns 4 black pins when 4 correct colors are in the correct place' do

      test_guess = mock_game.secret_code
      results = mock_game.get_results(test_guess)
      expect(results[:black_pins]).to eq 4
      expect(results[:white_pins]).to eq 0

    end

    it 'returns 3 black pins when 3 correct colors are in the correct place' do

      test_guess = %i[red blue green purple]
      results = mock_game.get_results(test_guess)
      expect(results[:black_pins]).to eq 3
      expect(results[:white_pins]).to eq 0
    end

    it 'returns 0 black and white pins when there are no correct colors' do

      test_guess = %i[purple purple purple purple]
      results = mock_game.get_results(test_guess)
      expect(results[:black_pins]).to eq 0
      expect(results[:white_pins]).to eq 0
    end

    it 'returns 2 black pins and 2 white pins when 2 correct colors are in the correct place and 2 correct colors are in the wrong place' do

      test_guess = %i[green green green yellow]
      results = mock_game.get_results(test_guess)
      expect(results[:black_pins]).to eq 2
      expect(results[:white_pins]).to eq 0
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

end