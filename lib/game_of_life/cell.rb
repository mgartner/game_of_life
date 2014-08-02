# Represents a cell in the Game of Life.
class Cell
  attr_accessor :alive, :neighbors

  # Initializes a living or dead cell.
  def initialize(alive = false)
    @alive = alive
    self
  end

end
