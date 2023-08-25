# frozen_string_literal: true

# Player object to interface with Connect Four
class Player
  attr_reader :symbol

  def initialize(symbol:)
    @symbol = symbol
  end

  def input
    gets.chomp
  end
end
