require 'mastermind_io'

class MockPrinter
    attr_reader :message, :puts, :print
    def initialize
        @message = nil
    end

    def puts(str)
        @message = str
    end

    def print(str)
        @message = str
    end
end

class MockGetter
    def gets
        "hello, world!"
    end
end



RSpec.describe "MastermindIO" do
    let(:mock_printer) { MockPrinter.new }
    let(:mock_getter) { MockGetter.new }
    let(:io) { MastermindIO.new(printer: mock_printer, getter: mock_getter) }
    before(:each) do
        @message = ""
    end

    describe '#print' do
        it 'passes the message to the printer method' do
            io.puts("hello, world")

            expect(mock_printer.message).to eq("hello, world")
        end
    end

    describe "#prompt(message)" do
        it "calls the print method on the given printer" do
            io.prompt("hello, world")
            expect(mock_printer.message).to eq("hello, world: ")
        end

        it "calls the get method and returns input" do
            input_message = io.prompt("some message")
            expect(input_message).to eq('hello, world!')
        end
    end
end