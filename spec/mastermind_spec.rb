require "mastermind"

RSpec.describe "Mastermind" do
    let(:new_game) { Mastermind.new }

    describe "#instructions" do
        it "generates the game instructions" do

            expect(new_game.instructions).not_to be_empty
            expect(new_game.instructions).to start_with("Welcome to Mastermind!\n")
        end
    end

    describe "#new_code" do
        let(:secret_code) { new_game.new_code }
        
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

        before do
            new_game.secret_code = [:red, :blue, :green, :yellow]
        end

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

    describe "#validate_colors(guess)" do
        it "returns true if all guess colors are valid options" do
            test_guess = [:red, :blue, :green, :yellow]
            expect(new_game.validate_colors(test_guess)).to eq true
        end

        it "returns false if any of the guess colors are invalid options" do
            test_guess = [:red, :blue, :oops, :yellow]
            expect(new_game.validate_colors(test_guess)).to eq false
        end
    end

    describe "#update_results(results)" do
        it "adds results to array" do
            test_guess = [:red,:red,:red,:red]
            results = new_game.get_results(test_guess)
            new_game.update_results(results)
            expect(new_game.history).to eq([results])
        end

        it "appends to existing history" do
            test_guess_a = [:red,:red,:red,:red]
            result_a = new_game.get_results(test_guess_a)
            new_game.update_results(result_a)

            test_guess_b = [:blue, :blue, :blue, :blue]
            result_b = new_game.get_results(test_guess_b)
            new_game.update_results(result_b)

            expect(new_game.history).to eq([result_a, result_b])
        end
    end

end
