$LOAD_PATH << File.join(File.expand_path(File.dirname('__FILE__')), '/tic_tac_toe')

require 'game'
require 'human'
require 'computer'
require 'square'
require 'board'
require 'win_checker'
require 'display'

game = Game.new
game.play
