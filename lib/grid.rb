# frozen_string_literal: true

require_relative 'column'

# Gameplay area for Connect Four
class Grid
  attr_reader :columns

  def initialize
    @columns = {
      first: Column.new,
      second: Column.new,
      third: Column.new,
      fourth: Column.new,
      fifth: Column.new,
      sixth: Column.new,
      seventh: Column.new
    }
  end

  def update(column, symbol)
    count = column.count
    return :full if column.full?

    column.squares[(column.squares.length - 1) - count] = symbol
    :success
  end

  def rows
    queue = []
    current_index = 0
    last_index = 6
    until current_index == last_index
      @columns.each_pair do |_key, value|
        queue << value.squares[current_index]
      end
      current_index += 1
    end
    queue
  end
end
