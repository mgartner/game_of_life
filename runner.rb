$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
require 'lib/game_of_life'
require 'method_profiler'

# Setup the game.
game = Game.new(30, 100)
game.setup_toad

# Clear the screen.
Printer.clear_screen!

t1 = Time.now


#profiler = MethodProfiler.observe(Board)

# Run the game.
index = 0
game.each_step do |board|
  index += 1
  #board.reprint
  if index >= 100
    break
  end
  #sleep(0.05)
end

puts Time.now - t1

#puts profiler.report
