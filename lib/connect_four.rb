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
    drop_piece(player)
  end

  private

  def valid_input?(input)
    return true if input.length == 1 && input.match?(/[1-7]/)

    puts 'Please pick a column from 1 thru 7'
  end

  def drop_piece(player)
    loop do
      selection = player.input
      selection unless valid_input?(selection)
      break if @grid.update(select_column(selection), player.symbol) == :success
    end
    :success
  end

  def select_column(selection)
    column_key = @grid.columns.keys[selection.to_i - 1]
    @grid.columns[column_key]
  end
end
