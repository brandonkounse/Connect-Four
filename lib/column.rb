# frozen_string_literal: true

# Column state passed to Grid class
class Column
  MAX_COUNT = 6

  attr_accessor :spots

  def initialize
    @spots = Array.new(6) { '⚪' }
  end

  def count
    MAX_COUNT - @spots.count('⚪')
  end

  def full?
    count == MAX_COUNT
  end
end
