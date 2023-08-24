# frozen_string_literal: true

# Column state passed to Grid class
class Column
  MAX_COUNT = 6

  attr_accessor :squares
  attr_reader :current_count

  def initialize
    @squares = Array.new(6) { '◯' }
    @current_count = 0
  end

  def count
    @current_count = MAX_COUNT - @squares.count('◯')
  end

  def full?
    @current_count == MAX_COUNT
  end
end
