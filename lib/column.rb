# frozen_string_literal: true

# Column state passed to Grid class
class Column
  attr_reader :row, :count

  def initialize
    @row = Array.new(6) { |i| i = nil }
    @count = 0
    @full = false
  end

  def full?
    @full = true if @row.all? { |spot| !spot.nil? }

    @full
  end
end
