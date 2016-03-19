$: << File.join(File.expand_path(File.dirname("__FILE__")), "/tic_tac_toe")

require 'game'
require 'player'
require 'human'
require 'computer'
require 'square'
require 'board'
require 'win_checker'

game = Game.new
game.play
