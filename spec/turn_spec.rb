require 'turn'

RSpec.describe "Turn" do

  let(:test_guess) { %i[red blue green yellow] }
  let(:test_turn) { Turn.with(test_guess) }
  let(:test_pins) { [1, 2] }

  describe "#with(guess)" do
    it "returns a new Turn with specific guess" do
      expect(test_turn.guess).to eq test_guess
    end

    it 'returns a new Turn with blank feedback' do
      expect(test_turn.feedback).to be_empty
    end
  end

  describe '#add(pins)' do
    it 'adds specified pins to an existing turn' do
      test_turn.add(test_pins)
      expect(test_turn.feedback).to eq test_pins
    end
  end

  describe 'to_s' do
    it 'returns a formatted string with the feedback and guess' do
      test_turn.add(test_pins)
      expect(test_turn.to_s).to eq "Black Pins: 1 | White Pins: 2 | Guess: [:red, :blue, :green, :yellow]\n"
    end
  end
end