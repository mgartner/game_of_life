# Represents a cell in the Game of Life.
class Cell

  # Initializes a living or dead cell.
  def initialize(alive = false)
    @alive = alive
    self
  end

  # Kills the Cell.
  def kill
    @alive = false
  end

  # Revives the Cell.
  def revive
    @alive = true
  end

  # Returns true if the Cell lives.
  def alive?
    return @alive
  end

end
