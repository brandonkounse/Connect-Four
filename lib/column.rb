# frozen_string_literal: true

# Column state passed to Grid class
class Column
  MAX_COUNT = 6

  attr_accessor :spots
  attr_reader :current_count

  def initialize
    @spots = Array.new(6) { '⚪' }
    @current_count = 0
  end

  def full?
    count
    @current_count == MAX_COUNT
  end

  private

  def count
    @current_count = MAX_COUNT - @spots.count('⚪')
  end
end
