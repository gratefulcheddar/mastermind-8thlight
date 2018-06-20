require "mastermind"

RSpec.describe "Mastermind" do
    describe "#instructions" do
        it "generates the game instructions" do
            new_game = Mastermind.new
            expect(new_game.instructions).to eq("Welcome to Mastermind!\n" + 
                "To play: The computer will choose a secret code comprised of 4 colors. The possible colors include RED, BLUE, GREEN, ORANGE, YELLOW, and PURPLE. The computer can choose any combination of colors, and they can be repeated.\n" + 
                "You will then take turns guessing the 4 color sequence. If you do not guess the correct pattern within 10 attempts, you lose. After each guess round, you will be given two numbers as feedback, the number of correct colors in correct places, and the number of correct colors in incorrect places.\n" +
                "During the guessing round, you will be able to enter input into the command line. The game will accept the correct spelling of each color, regarldess of capitalization. It will also accept a few navigational commands: !quit which will quit the game after confirmation, and !restart which starts a new game after confirmation")
        end
    end

    describe "#new_code" do
        new_game = Mastermind.new
        secret_code = new_game.new_code

        it "returns an array" do
            expect(secret_code.class).to eq Array
        end
        it "returns an array with 4 items" do
            expect(secret_code.count).to eq 4
        end
        it "returns an array with 4 valid colors" do
            COLOR_OPTIONS = [:red, :blue, :green, :orange, :purple, :yellow]
            
            for color in secret_code do
                expect(COLOR_OPTIONS.include? color).to eq true
            end
        end
        it "returns an array with 4 random colors" do
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

end
