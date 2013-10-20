$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
require 'lib/game_of_life'

# Setup the game.
game = Game.new(30, 100)
game.setup_glider_gun

# Clear the screen.
Printer.clear_screen!


# Run the game.
game.each_step do |board, index|
  board.reprint
  #sleep(0.05)
end
