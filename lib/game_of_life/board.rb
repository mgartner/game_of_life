require 'matrix'
#require 'game_of_life/cell'

# The Board represents the state of all the cells and can calculatethe next
# state based on the current, governed by the set of rules.
class Board

  # The initializer for the Board creates a new 2D board that is size X size.
  def initialize(row_count, column_count)
    @width = column_count
    @height = row_count
    @cell_matrix = Matrix.build(@height, @width) { |row, col| Cell.new }
    self
  end

  # Get the cell at the specified row and column.
  def [](row, col)
    return @cell_matrix[row, col]
  end

  # Returns true if the cell is alive and will die on the next round.
  def dying?(row, col)
    cell = self[row, col]
    if cell.alive?
      live_neighbor_count = neighbor_count(row, col)
      if live_neighbor_count == 2 || live_neighbor_count == 3
        return false
      else
        return true
      end
    end
    return false
  end

  # Returns true if the cell is dead and will revive on the next round.
  def reviving?(row, col)
    cell = self[row, col]
    if !cell.alive?
      live_neighbor_count = neighbor_count(row, col)
      if live_neighbor_count == 3
        return true
      end
    end
    return false
  end

  # Returns true if the cell is living and will remain alive.
  def living?(row, col)
    cell = self[row, col]
    if cell.alive?
      live_neighbor_count = neighbor_count(row, col)
      if live_neighbor_count == 2 || live_neighbor_count == 3
        return true
      end
    end
    return false
  end
  
  # Given the current state of the cells, advances to the next state based
  # on the following rules:
  #   1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
  #   2. Any live cell with two or three live neighbours lives on to the next generation.
  #   3. Any live cell with more than three live neighbours dies, as if by overcrowding.
  #   4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  def advance
    new_cell_matrix = Matrix.build(@height, @width) { |rol, col| Cell.new }
    for i in (0..@height-1)
      for j in (0..@width-1)
        if living?(i, j) || reviving?(i, j)
          new_cell_matrix[i, j].revive
        end
      end
    end
    @cell_matrix = new_cell_matrix
  end

  # Returns the number of live neighbors of the cell at the given row and 
  # column.
  def neighbor_count(row, col)
    count = 0
    each_neighbor(row, col) do |cell|
      count += 1 if cell.alive?
    end
    return count
  end

  # Yields each neighbor of the cell at the given row and column.
  def each_neighbor(row, col, &block)
    for i in (row-1..row+1)
      if i > -1 && i < @height
        for j in (col-1..col+1)
          if j > -1 && j < @width && !(i == row && j == col)
            block.call(@cell_matrix[i, j])
          end
        end
      end
    end
  end

  # Yields each cell in the board.
  def each_cell(&block)
    @cell_matrix.to_a.flatten.each do |cell|
      block.call(cell)
    end
  end

  # Reprint the board
  def reprint
    Printer.move_to_home!
    for i in (0..@height-1)
      row_string = ""
      for j in (0..@width-1)
        if dying?(i, j)
          row_string << "\e[33mX\e[0m"
        elsif living?(i, j)
          row_string << "\e[32mX\e[0m"
        else
          row_string << "-"
        end
      end
      Printer.reputs(row_string)
    end
  end

end
