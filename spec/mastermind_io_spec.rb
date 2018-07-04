require 'mastermind_io'

class FakeOutputMock
  attr_reader :message

  def initialize
    @message = ''
  end

  def puts(message)
    @message = message
  end

  def print(message)
    @message = message
  end
end

class FakeInputMock
  def gets
    "red blue green yellow\n"
  end
end

class NoPutsMethod
  def print; end
end
class NoPrintMethod
  def puts; end
end
class NoGetsMethod
end

RSpec.describe 'MastermindIO' do
  let(:mock_printer) { FakeOutputMock.new }
  let(:mock_getter) { FakeInputMock.new }
  let(:mastermind_io) { MastermindIO.new(printer: mock_printer, getter: mock_getter) }

  describe '#new' do
    it 'raises an NoMethodError if printer does not respond to puts' do
      no_puts_method = NoPutsMethod.new
      expect{ MastermindIO.new(printer: no_puts_method, getter: mock_getter) }.to raise_error(NoMethodError)
    end

    it 'raises an NoMethodError if printer does not respond to print' do
      no_print_method = NoPrintMethod.new
      expect{ MastermindIO.new(printer: no_print_method, getter: mock_getter) }.to raise_error(NoMethodError)
    end

    it 'raises a NoMethodError if getter does not respond to get' do
      no_gets_method = NoGetsMethod.new
      expect{ MastermindIO.new(printer: mock_printer, getter: no_gets_method) }.to raise_error(NoMethodError)
    end

    it 'default printer and getter do not raise errors' do
      expect{ MastermindIO.new }.to_not raise_error
    end
  end

  describe '#output' do
    it "sends a message to MastermindIO's printer" do
      mastermind_io.output('Hello, MastermindIO!')
      expect(mock_printer.message).to eq 'Hello, MastermindIO!'
    end
  end

  describe '#prompt' do
    it "sends a message to MastermindIO's printer" do
      mastermind_io.prompt('Prompt Message')
      expect(mock_printer.message).to eq 'Prompt Message: '
    end

    it "returns a message from MastermindIO's getter" do
      test_input = mastermind_io.prompt('Prompt Message')
      expect(test_input).to eq "red blue green yellow"
    end
  end

  describe '#get_guess(correct_length)' do
    context 'when guess is correct length and valid color options' do
      it "returns a formatted guess from MastermindIO's getter" do
        test_guess = mastermind_io.get_guess(4)
        expect(test_guess).to eq [:red, :blue, :green, :yellow]
      end
    end
  end
end
