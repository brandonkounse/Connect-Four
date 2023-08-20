# frozen_string_literal: true

# Column state passed to Grid class
class Column
  MAX_COUNT = 6

  attr_accessor :row
  attr_reader :current_count

  def initialize
    @row = Array.new(6) { |i| i = nil }
    @current_count = 0
    @full = false
  end

  def count
    @current_count = MAX_COUNT - @row.count(nil)
  end

  def full?
    @full = true if @current_count == MAX_COUNT

    @full
  end
end
