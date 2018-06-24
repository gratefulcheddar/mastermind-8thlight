require "mastermind"
require "stringio"

RSpec.describe "Mastermind" do

    new_game = Mastermind.new

    describe "#instructions" do
        it "generates the game instructions" do

            expect(new_game.instructions).not_to be_empty
            expect(new_game.instructions).to start_with("Welcome to Mastermind!\n")
        end
    end

    describe "#new_code" do
        secret_code = new_game.new_code

        it "has 4 colors" do
            expect(secret_code.count).to eq 4
        end

        it "uses valid colors" do
            for color in secret_code do
                expect(Mastermind::COLOR_OPTIONS.include? color).to eq true
            end
        end

        it "is randomly generated" do
            is_random = false
            (1...10).each do
                if Mastermind.new.new_code != Mastermind.new.new_code
                    is_random = true
                    break
                end
            end
            expect(is_random).to eq true
        end
    end

    describe "#get_guess" do
        it "reads 4 guesses from user" do

            io = StringIO.new
            io.puts "red\n"
            io.puts "green\n"
            io.puts "blue\n"
            io.puts "red\n"
            io.rewind

            $stdin = io

            new_game = Mastermind.new
            guess = new_game.get_guess

            $stdin = STDIN

            expect(guess).to eq ["red", "green", "blue", "red"]
        end
    end

    describe "#prompt_for_user_input" do
        it "includes all color options" do
            new_game = Mastermind.new
            expect(new_game.prompt_for_user_input).to include("red", "blue", "green", "orange", "purple", "yellow")
        end
    end
end
