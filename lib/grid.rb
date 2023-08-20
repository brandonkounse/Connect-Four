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
  end
end
