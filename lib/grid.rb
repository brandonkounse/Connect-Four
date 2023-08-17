# frozen_string_literal: true

# Gameplay area for Connect Four
class Grid
  attr_reader :columns

  def initialize
    @columns = Array.new(7) { Array.new(6) }
  end
end
