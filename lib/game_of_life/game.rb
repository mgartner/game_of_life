# This Game class is responsible for running the game over time.
class Game

  # The Game initializer.
  def initialize(width, height)
    @board = Board.new(width, height)
    self
  end

  # Seeds the cell at the given position.
  # Input should be an array, i.e. [0,0]
  def seed(x, y)
    @board[x,y].alive = true
  end

  # Run a game with the given size.
  def each_step(&block)
    while true
      block.call(@board)
      @board.advance()
    end
  end

  def setup_toad
    seed(10, 10)
    seed(10, 11)
    seed(10, 12)
    seed(11, 9)
    seed(11, 10)
    seed(11, 11)
  end

  def setup_glider
    seed(0, 0)
    seed(0, 2)
    seed(1, 1)
    seed(1, 2)
    seed(2, 1)
  end

  def setup_random(number)
    number.times do
      seed(rand(30), rand(100))
    end
  end

  def setup_glider_gun
    # left block
    seed(5, 1)
    seed(5, 2)
    seed(6, 1)
    seed(6, 2)

    # left piston
    seed(5, 11)
    seed(6, 11)
    seed(7, 11)
    seed(4, 12)
    seed(8, 12)
    seed(3, 13)
    seed(9, 13)
    seed(3, 14)
    seed(9, 14)
    seed(6, 15)
    seed(4, 16)
    seed(8, 16)
    seed(5, 17)
    seed(6, 17)
    seed(7, 17)
    seed(6, 18)

    # right piston
    seed(3, 21)
    seed(4, 21)
    seed(5, 21)
    seed(3, 22)
    seed(4, 22)
    seed(5, 22)
    seed(2, 23)
    seed(6, 23)
    seed(1, 25)
    seed(2, 25)
    seed(6, 25)
    seed(7, 25)

    # right block
    seed(3, 35)
    seed(3, 36)
    seed(4, 35)
    seed(4, 36)
  end

end
