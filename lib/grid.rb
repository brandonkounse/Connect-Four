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

    column.row[(column.row.length - 1) - count] = symbol
    :success
  end

  # function for yielding every element of every column in sequential order
  def list(&block)
    current_index = 0
    last_index = 6
    until current_index == last_index
      @columns.each_pair do |_key, value|
        yield value.row[current_index] if block_given?
      end
      current_index += 1
    end
  end
end
