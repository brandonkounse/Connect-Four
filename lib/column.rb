# frozen_string_literal: true

# Column state passed to Grid class
class Column
  attr_reader :row, :count, :full

  def initialize
    @row = Array.new(6)
    @count = 0
    @full = false
  end
end
