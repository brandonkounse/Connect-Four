# frozen_string_literal: true

# Player object to interface with Connect Four
class Player
  attr_reader :name, :symbol

  # :black_symbol { U+26AB }
  # :red_symbol { U+1F534 }

  def initialize(name:, symbol:)
    @name = name
    @symbol = symbol
  end

  def input
    gets.chomp
  end
end
