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
    get_input(player)
  end

  private

  def valid_input?(input)
    return true if input.length == 1 && input.match?(/[1-7]/)

    puts 'Please pick a column from 1 thru 7'
    false
  end

  def get_input(player)
    valid_input?(player.input)
  end

  def drop_piece(player); end
end
