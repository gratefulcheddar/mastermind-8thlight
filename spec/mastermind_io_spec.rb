require 'mastermind_io'

RSpec.describe 'MastermindIO' do

  let(:mastermind_io) { MastermindIO.new }

  describe '#new' do
    it 'default printer and getter do not raise errors' do
      expect { mastermind_io }.to_not raise_error
    end
  end

  describe '#output' do
    it "sends a message to MastermindIO's printer" do
      expect($stdout).to receive(:puts).with('Hello, MastermindIO!')
      mastermind_io.output('Hello, MastermindIO!')
    end
  end

  describe '#prompt' do
    it "sends a message to MastermindIO's printer" do
      allow($stdin).to receive(:gets).and_return('something')
      expect($stdout).to receive(:print).with('Prompt Message: ')
      mastermind_io.prompt('Prompt Message')
    end

    it "returns a message from MastermindIO's getter" do
      allow($stdout).to receive(:print).with('Prompt Message: ')
      allow($stdin).to receive(:gets).and_return('red blue green yellow')
      test_input = mastermind_io.prompt('Prompt Message')
      expect(test_input).to eq 'red blue green yellow'
    end
  end

  describe '#get_code' do
    it 'returns a code from stdin' do
      allow($stdout).to receive(:print)
      allow($stdin).to receive(:gets).and_return("red blue green yellow")
      test_guess = mastermind_io.get_code
      expect(test_guess).to eq %i[red blue green yellow]
    end
  end

  describe '#get_game_mode' do
    it 'returns a valid game mode from stdin' do
      allow($stdout).to receive(:puts)
      allow($stdout).to receive(:print)
      allow($stdin).to receive(:gets).and_return("auto")
      game_mode = mastermind_io.get_game_mode
      expect(Rules::GAME_MODES.include?(game_mode)).to eq true
    end
  end

  describe '#restart?' do
    context "when user inputs 'yes'" do
      it 'returns true' do
        allow($stdout).to receive(:print)
        allow($stdin).to receive(:gets).and_return("yes")
        expect(mastermind_io.send(:restart?)).to eq true
      end
    end

    context "when user inputs 'no'" do
      it "returns false" do
        allow($stdout).to receive(:print)
        allow($stdin).to receive(:gets).and_return("yes")
        expect(mastermind_io.send(:restart?)).to eq true
      end
    end
    
  end
end
