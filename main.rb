require 'Matrix'
require './lib/matrix.rb'
require './lib/tic-tac-toe.rb'
require './lib/game.rb'

# create a class object for TicTacToe and call the game method
system "cls"
game = Game.new
result = game.game

if result == 0 then
    puts ('The game ends in a tie')
elsif result == 1
    puts ("Player 1 wins!")
else
    puts ("Player 2 wins!")
end