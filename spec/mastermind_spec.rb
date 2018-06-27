require "mastermind"

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

    describe "#get_results(guess)" do

        class Mastermind
            attr_accessor :secret_code
        end

        new_game.secret_code = [:red, :blue, :green, :yellow]

        it "returns 4 black pins when 4 correct colors are in the correct place" do

            test_guess = new_game.secret_code
            results = new_game.get_results(test_guess)
            expect(results[:black_pins]).to eq 4
            expect(results[:white_pins]).to eq 0

        end

        it "returns 3 black pins when 3 correct colors are in the correct place" do

            test_guess = [:red, :blue, :green, :purple]
            results = new_game.get_results(test_guess)
            expect(results[:black_pins]).to eq 3
            expect(results[:white_pins]).to eq 0
        end

        it "returns 0 black and white pins when there are no correct colors" do

            test_guess = [:purple, :purple, :purple, :purple]
            results = new_game.get_results(test_guess)
            expect(results[:black_pins]).to eq 0
            expect(results[:white_pins]).to eq 0
        end

        it "returns 2 black pins and 2 white pins when 2 correct colors are in the correct place and 2 correct colors are in the wrong place" do

            test_guess = [:green, :green, :green, :yellow]
            results = new_game.get_results(test_guess)
            expect(results[:black_pins]).to eq 2
            expect(results[:white_pins]).to eq 0
        end
    end

    describe "#validate_guess_colors(guess)" do
        it "returns true if all guess colors are valid options" do
            test_guess = [:red, :blue, :green, :yellow]
            expect(new_game.validate_guess_colors(test_guess)).to eq true
        end

        it "returns false if any of the guess colors are invalid options" do
            test_guess = [:red, :blue, :oops, :yellow]
            expect(new_game.validate_guess_colors(test_guess)).to eq false
        end
    end

end
