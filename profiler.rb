$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
require 'lib/game_of_life'

game = Game.new(30, 100)
game.setup_glider_gun

start_time = Time.now

# Run the game.
game.each_step do |board, index|
  break if index == 100
end

end_time = Time.now

puts "seconds: #{end_time - start_time}"
