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
    return :success if column.update(symbol)

    :full
  end

  def rows
    queue = []
    current_index = 0
    last_index = 6
    until current_index == last_index
      @columns.each_pair do |_key, value|
        queue << value.spots[current_index]
      end
      current_index += 1
    end
    queue
  end

  def full?
    @columns.each_pair.all? do |_key, value|
      value.count
      value.full?
    end
  end
end
