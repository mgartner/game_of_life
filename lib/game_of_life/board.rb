# The Board represents the state of all the cells and can calculatethe next
# state based on the current, governed by the set of rules.
class Board

  # The initializer for the Board creates a new 2D board that is size X size.
  def initialize(row_count, column_count)
    @width = column_count
    @height = row_count
    @cell_matrix = new_matrix(row_count, column_count)
    self
  end

  # Creates a new matrix via 2D arrays.
  def new_matrix(rows, cols)
    Array.new(rows) { Array.new(cols) { Cell.new } }
  end

  # Get the cell at the specified row and column.
  def [](row, col)
    return @cell_matrix[row][col]
  end

  # Given the current state of the cells, advances to the next state based
  # on the following rules:
  #   1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
  #   2. Any live cell with two or three live neighbours lives on to the next generation.
  #   3. Any live cell with more than three live neighbours dies, as if by overcrowding.
  #   4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  def advance

    # Calculate the neighbors of each cell.
    for i in (0..@height-1)
      for j in (0..@width-1)
        cell = @cell_matrix[i][j]
        cell.neighbors = neighbor_count(i, j)
      end
    end

    # Kill, keep alive, or revive each cell base on neighbor count.
    for i in (0..@height-1)
      for j in (0..@width-1)
        cell = @cell_matrix[i][j]
        if cell.alive
          if cell.neighbors != 2 && cell.neighbors != 3
            cell.alive = false
          end
        else
          if cell.neighbors == 3
            cell.alive = true
          end
        end
      end
    end
  end

  # Yields each cell with an x and y coordinate.
  def each_cell(&block)
    for i in (0..@height-1)
      for j in (0..@width-1)
        block.call(i, j, @cell_matrix[i][j])
      end
    end
  end

  # Yields each neighbor of the cell at the given row and column.
  def each_neighbor(row, col, &block)
    for i in (row-1..row+1)
      if i > -1 && i < @height
        for j in (col-1..col+1)
          if j > -1 && j < @width && !(i == row && j == col)
            block.call(self[i, j])
          end
        end
      end
    end
  end

  # Returns the number of live neighbors of the cell at the given row and 
  # column.
  def neighbor_count(row, col)
    count = 0
    for i in (row-1..row+1)
      if i > -1 && i < @height
        for j in (col-1..col+1)
          if j > -1 && j < @width && !(i == row && j == col)
            count += 1 if @cell_matrix[i][j].alive
          end
        end
      end
    end
    return count
  end

  # Reprint the board
  def reprint
    Printer.move_to_home!
    for i in (0..@height-1)
      row_string = ""
      for j in (0..@width-1)
        cell = self[i, j]
        if cell.alive
          row_string << "\e[32mX\e[0m"
        else
          row_string << "-"
        end
      end
      Printer.reputs(row_string)
    end
  end

end
