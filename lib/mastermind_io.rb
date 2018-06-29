class Printer
    def puts(str)
        puts(str)
    end

    def print(str)
        $stdout.print(str)
    end
end

class Getter 
    def gets
        gets
    end
end

class MastermindIO
    def initialize(printer: Printer.new, getter: Getter.new)
        @printer = printer
        @getter = getter
    end

    def puts(message)
        @printer.puts(message)
    end

    def prompt(message)
        @printer.print("#{message}: ")
        @getter.gets.chomp
    end
end