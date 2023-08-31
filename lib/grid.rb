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
      puts row.join(' | ')
    end
  end

  def four_in_row?(row_index, symbol)
    winning_indices = [[0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6]]
    winning_indices.any? do |indices|
      @spots.transpose[row_index][indices.first, indices.length].all? { |element| element == symbol }
    end
  end

  def four_in_column?(column_index, symbol)
    winning_indices = [[0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5]]
    winning_indices.any? do |indices|
      @spots[column_index][indices.first, indices.length].all? { |element| element == symbol }
    end
  end

  def four_in_diagonal; end

  def four_in_reverse_diagonal; end
end
