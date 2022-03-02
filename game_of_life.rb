class GameOfLife
  def get_next_grid(current_grid)
    new_grid = current_grid

    new_grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        living_neighbours_count = number_of_living_neighbours(row_index, column_index, new_grid)
        new_state_of_cell(cell, living_neighbours_count)
      end
    end
  end

  def new_state_of_cell(cell, living_neighbours_count)
    case cell
      when :live
        new_state = new_state_of_live_cell(living_neighbours_count)
      when :dead
        new_state = new_state_of_dead_cell(living_neighbours_count)
    end
    return new_state
  end

  def number_of_living_neighbours(cell_row, cell_column, grid)
    living_neighbours = 0
    if cell_column >= 1
      living_neighbours += 1 if grid[cell_row][cell_column - 1] == :live  
    end
    living_neighbours += 1 if grid[cell_row][cell_column + 1] == :live

    return living_neighbours
  end

  private
  def new_state_of_live_cell(living_neighbours_count)
    if living_neighbours_count == 2 || living_neighbours_count == 3
      :live
    else
      :dead
    end
  end

  def new_state_of_dead_cell(living_neighbours_count)
    if living_neighbours_count == 3
      :live
    else 
      :dead
    end
  end
end
