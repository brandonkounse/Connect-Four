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
      :full
    elsif @spots[column][index] == EMPTY_SPOT
      @spots[column][index] = symbol
    else
      drop_piece(column, symbol, index - 1)
    end
  end

  def render
    row = format_grid
    puts "\n #{row.shift(@spots.length).join(' | ')}" until row.empty?
  end

  private

  def format
    row = []
    index = 0
    row_length = 6
    until index == row_length
      @spots.each do |column|
        row << column[index]
      end
      index += 1
    end
    row
  end
end
