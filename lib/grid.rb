# frozen_string_literal: true

# Gameplay area for Connect Four
class Grid
  EMPTY_SPOT = '⚪'
  SEQUENCE_LENGTH = 4
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
    check_sequence_of_four?(grid: @spots.transpose, index: row_index, token: symbol)
  end

  def four_in_column?(column_index, symbol)
    check_sequence_of_four?(grid: @spots, index: column_index, token: symbol)
  end

  def four_in_diagonal?(column_index, symbol)
    down_right = [[1, 1], [-1, -1]]
    up_right = [[1, -1], [-1, 1]]
    get_full_diagonal(column_index, down_right)
    get_full_diagonal(column_index, up_right)
  end

  private

  def check_sequence_of_four?(grid:, index:, token:)
    first_iteration = 0
    max_iterations = grid[index].length % SEQUENCE_LENGTH
    (first_iteration..max_iterations).any? do |iteration|
      grid[index][iteration, SEQUENCE_LENGTH].all? { |element| element == token }
    end
  end

  def get_full_diagonal(column_index, directional_indices)
    row_index = @spots[column_index].count(EMPTY_SPOT)
    subset = [[column_index, row_index]]
    directional_indices.each do |direction|
      y = direction[0]
      x = direction[1]
      until !(subset.last[0] + y).between?(0, 6) || !(subset.last[1] + x).between?(0, 7)
        next_spot = [(subset.last[0] + y), (subset.last[1] + x)]
        subset << next_spot
      end
    end
    subset.uniq.sort.map { |x, y| @spots[x][y] }
  end
end
