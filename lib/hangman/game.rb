module Hangman
  class Game
    def initialize
      @dictionary = Dictionary.new
      Dir.mkdir("saved_games") unless Dir.exist?("saved_games")
      puts "Would you like to open a saved game?"
      if gets.chomp == "yes"
        puts "What is the file name?"
        saved_game = gets.chomp
        load_game(saved_game)
      else
        @score = Score.new(@dictionary.word)
      end
    end

    def start
      until @score.turns_left == 0 || @score.result.none? { |character| character == "-" }
        puts "Make a guess:"
        guess = gets.chomp.downcase
        if guess == "save"
          @score.turns_left += 1
          puts "What should the save game be called?"
          file_name = gets.chomp
          save_game(file_name)
        elsif @score.word.include?(guess)
          indexes = []
          @score.word.each_with_index do |character, index|
            if character == guess
              indexes << index
            end
          end
          indexes.each do |index|
            @score.result[index] = guess
          end
        else
          @score.wrong_characters << guess
          puts "You've guessed wrong"
        end
        @score.show_score
        @score.turns_left -= 1
        if @score.result.none? { |character| character == "-"}
          puts "Congratulations, you have won!"
        elsif @score.turns_left == 0
          puts "Better luck next time"
        end
      end
    end

    private

    def save_game(file_name)
      file = File.new("saved_games/" + file_name + ".yaml", "w")
      file.puts YAML.dump(@score)
    end

    def load_game(file_name)
      file = File.new("saved_games/" + file_name + ".yaml", "r")
      yaml = file.read
      @score = YAML.load(yaml)
      @score.show_score
    end
  end
end
