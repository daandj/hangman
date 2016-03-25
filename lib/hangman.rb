require "yaml"

require_relative "hangman/game.rb"
require_relative "hangman/dictionary.rb"
require_relative "hangman/score.rb"

game = Hangman::Game.new
game.start
