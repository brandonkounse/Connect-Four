# frozen_string_literal: true

# Gameplay area for Connect Four
class Grid
  EMPTY_SPOT = '⚪'
  attr_reader :spots

  def initialize
    @spots = Array.new(7) { Array.new(6) { EMPTY_SPOT } }
  end

  def drop_piece(column, symbol, index = 5)
    if @spots[column][index].nil?
      false
    elsif @spots[column][index] == EMPTY_SPOT
      @spots[column][index] = symbol
      true
    else
      drop_piece(column, symbol, index - 1)
    end
  end

  def render
    @spots.transpose.each do |row|
      puts "\n#{row.join(' | ')}"
    end
  end

  def four_in_row?(row_index, symbol)
    row_indices = [[0, 4], [1, 4], [2, 4], [3, 4]]
    check_sequence_of_four?(indices: row_indices, grid: @spots.transpose, index: row_index, token: symbol)
  end

  def four_in_column?(column_index, symbol)
    column_indices = [[0, 4], [1, 4], [2, 4]]
    check_sequence_of_four?(indices: column_indices, grid: @spots, index: column_index, token: symbol)
  end

  def four_in_diagonal?(column_index, symbol)
    diagonal_indices = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    row_index = @spots[column_index].count(EMPTY_SPOT)
    diagonal_indices.any? do |direction|
      mini = [[column_index, row_index]]
      y = direction[0]
      x = direction[1]
      until mini.length == 4 || !(mini.last[0] + y).between?(0, 5) || !(mini.last[1] + x).between?(0, 6)
        mini << [(mini.last[0] + y), (mini.last[1] + x)]
      end
      mini.map! { @spots[y][x] }
      mini.all? { |element| element == symbol }
    end
  end

  private

  def check_sequence_of_four?(indices:, grid:, index:, token:)
    indices.any? do |sequence|
      grid[index][sequence.first, sequence.last].all? { |element| element == token }
    end
  end
end
