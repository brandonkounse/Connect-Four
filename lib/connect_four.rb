# frozen_string_literal: true

require_relative 'grid'
require_relative 'player'
require_relative 'instructions'

# Game logic
class ConnectFour
  RED = '🔴'
  BLACK = '⚫'
  attr_reader :grid, :player_red, :player_black

  def initialize
    @grid = Grid.new
    @player_red = Player.new(symbol: RED)
    @player_black = Player.new(symbol: BLACK)
  end

  def start
    Instructions.start
    loop do
      case gets.chomp
      when '1'
        play
      when '2'
        break
      else
        puts "Please enter '1' to start a new game, or '2' to exit!"
      end
    end
  end

  def play
    loop do
      handle_turn(@player_red)
      break if over?(@player_red)

      handle_turn(@player_black)
      break if over?(@player_black)
    end
  end

  private

  def handle_turn(player)
    system 'clear'
    display_grid
    Instructions.turn(player)
    take_turn(player)
  end

  def take_turn(player)
    loop do
      selection = prompt_for_column(player)
      break if drop_piece(selection, player.symbol) == :success

      print 'Column full! Pick another column: '
    end
  end

  def prompt_for_column(player)
    loop do
      selection = player.input
      return selection if valid_input?(selection)

      print 'Please pick a column from 1 thru 7: '
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

  def over?(player)
    # check if player has won
    draw?
  end

  def draw?
    @grid.full?
  end

  def display_grid
    current_grid = @grid.rows
    puts "\n #{current_grid.shift(7).join('  | ')}" until current_grid.empty?
  end
end
