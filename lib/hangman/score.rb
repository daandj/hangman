module Hangman
  class Score
    attr_accessor :result, :word, :turns_left, :wrong_characters

    def initialize(word)
      @result = Array.new(word.length, "-")
      @word = word.downcase.split(//)
      @turns_left = 9
      @wrong_characters = []
    end

    def show_score
      puts "Score: "
      puts @result.join
      puts "Turns left: " + @turns_left.to_s
      puts "Characters guessed wrong: " + @wrong_characters.join(", ")
    end
  end
end
