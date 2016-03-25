module Hangman
  class Game
    def initialize
      @dictionary = Dictionary.new
      @result = Array.new(@dictionary.word.length, "-")
      @word = @dictionary.word.downcase.split(//)
      puts @word
      @turns_left = 9
      @wrong_characters = []
    end

    def start
      puts "Would you like to open a saved game?"
      if gets.chomp == "yes" then saved_game = gets.chomp end
      until @turns_left == 0 || @result.none? { |character| character == "-" }
        puts "Make a guess:"
        guess = gets.chomp.downcase
        if guess == "save"
          save_game
        elsif @word.include?(guess)
          indexes = []
          @word.each_with_index do |character, index|
            if character == guess
              indexes << index
            end
          end
          indexes.each do |index|
            @result[index] = guess
          end
        else
          @wrong_characters << guess
          puts "You've guessed wrong"
        end
        show_score
        @turns_left -= 1
      end
    end

    private

    def show_score
      puts "Score: "
      puts @result.join
      puts "Turns left: " + @turns_left.to_s
      puts "Characters guessed wrong: " + @wrong_characters.join(", ")
    end

    def save_game

    end

    def load_game

    end
  end
end
