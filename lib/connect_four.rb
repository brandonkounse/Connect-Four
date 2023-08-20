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
      selection = player.input
      break if valid_input?(selection)
    end
    drop_piece(player, selection)
  end

  private

  def valid_input?(input)
    return true if input.length == 1 && input.match?(/[1-7]/)

    puts 'Please pick a column from 1 thru 7'
    false
  end

  def drop_piece(player, selection); end

  def select_column(selection); end
end
