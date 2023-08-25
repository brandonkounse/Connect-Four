# frozen_string_literal: true

require_relative 'grid'
require_relative 'player'

# Game logic
class ConnectFour
  attr_reader :grid, :player_red, :player_black

  def initialize
    @grid = Grid.new
    @player_red = Player.new(name: 'player one', symbol: '🔴')
    @player_black = Player.new(name: 'player two', symbol: '⚫')
  end

  def take_turn(player)
    loop do
      selection = prompt_for_column(player)
      break if drop_piece(selection, player.symbol) == :success
    end
  end

  private

  def prompt_for_column(player)
    loop do
      selection = player.input
      return selection if valid_input?(selection)

      puts 'Please pick a column from 1 thru 7'
    end
  end

  def valid_input?(input)
    input.length == 1 && input.match?(/[1-7]/)
  end

  def drop_piece(column, symbol)
    column_index = column.to_i - 1
    selected_column = @grid.columns.keys[column_index]
    @grid.update(@grid.columns[selected_column], symbol)
  end
end
