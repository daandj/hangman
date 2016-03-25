module Hangman
  class Game
    def initialize
      @dictionary = Dictionary.new
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
          save_game
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
      end
    end

    private

    def save_game(file_name)
      @game_file = Gamefile.new(file_name)
      yaml = YAML::dump(@score)
    end

    def load_game(file_name)
      @game_file = Gamefile.new(file_name)
      yaml = @game_file.read
      YAML::load(yaml)
    end
  end
end
