# frozen_string_literal: true

# Gameplay area for Connect Four
class Grid
  EMPTY_SPOT = '⚪'
  SEQUENCE_LENGTH = 4

  attr_reader :columns

  def initialize
    @columns = Array.new(7) { Array.new(6) { EMPTY_SPOT } }
  end

  def update_column(index, symbol, position = 5)
    if columns[index][position].nil?
      false
    elsif columns[index][position] == EMPTY_SPOT
      columns[index][position] = symbol
      true
    else
      update_column(index, symbol, position - 1)
    end
  end

  def render
    rows.each do |row|
      puts "\n#{row.join(' | ')}"
    end
  end

  def four_in_row?(column_index, symbol)
    index = top_row_at(column_index)
    check_sequence_of_four?(subset: rows[index], token: symbol)
  end

  def four_in_column?(index, symbol)
    check_sequence_of_four?(subset: columns[index], token: symbol)
  end

  def four_in_diagonal?(column_index, symbol)
    down_right = [[1, 1], [-1, -1]]
    up_right = [[1, -1], [-1, 1]]
    diagonal = construct_diagonal(column_index, down_right)
    anti_diagonal = construct_diagonal(column_index, up_right)
    check_sequence_of_four?(subset: diagonal, token: symbol) || check_sequence_of_four?(subset: anti_diagonal, token: symbol)
  end

  private

  def rows
    columns.transpose
  end

  def top_row_at(column_index)
    columns[column_index].count(EMPTY_SPOT)
  end

  def check_sequence_of_four?(subset:, token:)
    first_iteration = 0
    max_iterations = subset.length % SEQUENCE_LENGTH
    (first_iteration..max_iterations).any? do |iteration|
      subset[iteration, SEQUENCE_LENGTH].all? { |element| element == token }
    end
  end

  def construct_diagonal(index, directional_indices)
    subset = [[index, top_row_at(index)]]
    directional_indices.each do |direction|
      y = direction[0]
      x = direction[1]
      until !(subset.last[0] + y).between?(0, 6) || !(subset.last[1] + x).between?(0, 7)
        next_spot = [(subset.last[0] + y), (subset.last[1] + x)]
        subset << next_spot
      end
    end
    subset.uniq.sort.map { |x, y| columns[x][y] }
  end
end
