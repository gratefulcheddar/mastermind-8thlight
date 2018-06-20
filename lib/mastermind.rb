class Mastermind

    COLOR_OPTIONS = [:red, :blue, :green, :orange, :purple, :yellow]

    def instructions
        "Welcome to Mastermind!\n" + 
        "To play: The computer will choose a secret code comprised of 4 colors. The possible colors include RED, BLUE, GREEN, ORANGE, YELLOW, and PURPLE. The computer can choose any combination of colors, and they can be repeated.\n" + 
        "You will then take turns guessing the 4 color sequence. If you do not guess the correct pattern within 10 attempts, you lose. After each guess round, you will be given two numbers as feedback, the number of correct colors in correct places, and the number of correct colors in incorrect places.\n" +
        "During the guessing round, you will be able to enter input into the command line. The game will accept the correct spelling of each color, regarldess of capitalization. It will also accept a few navigational commands: !quit which will quit the game after confirmation, and !restart which starts a new game after confirmation"
    end

    def new_code
        secret_code = []
        (1..4).each do
            secret_code << COLOR_OPTIONS[rand(6)]
        end
        secret_code
    end
end