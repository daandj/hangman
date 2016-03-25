module Hangman
  class Dictionary
    attr_accessor :word

    def initialize
      valid_words = File.readlines("lib/resources/dictionary.txt").select { |word| word.length > 5 && word.length < 12 }
      @word = valid_words[rand(valid_words.length)].chomp
      puts @word
    end
  end
end
