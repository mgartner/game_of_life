Game of Life
============

Simple Game of Life I wrote in Ruby quite a while ago. It runs completely in a terminal using a character matrix to visualize the game.

To run the game:

    $ ruby runner.rb
    
The game is setup with a glider gun by default. I created 3 other setups as well. Edit the `runner.rb` file to try them.

```ruby
# Initialize with a toad.
game.setup_toad

# Initialize with a glider.
game.setup_glider

# Initialize with a glider gun.
game.setup_glider_gun

# Initialize a random setup.
game.setup_random(1000)
```
