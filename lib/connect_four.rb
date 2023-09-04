# frozen_string_literal: true

require_relative 'grid'
require_relative 'player'
require_relative 'instructions'

# Game logic
class ConnectFour
  RED = '🔴'
  BLACK = '⚫'

  attr_reader :grid, :player_red, :player_black, :previous_move

  def initialize
    @grid = Grid.new
    @player_red = Player.new(symbol: RED)
    @player_black = Player.new(symbol: BLACK)
    @previous_move = nil
  end

  def start
    Instructions.start
    loop do
      case gets.chomp
      when '1'
        play
        break
      when '2'
        break
      else
        puts "Please enter '1' to start a new game, or '2' to exit!"
      end
    end
  end

  private

  def play
    loop do
      handle_turn(player_red)
      break if over?(player_red)

      handle_turn(player_black)
      break if over?(player_black)
    end
    ending
  end

  def handle_turn(player)
    system 'clear'
    display_grid
    Instructions.turn(player)
    take_turn(player)
  end

  def take_turn(player)
    loop do
      selection = prompt_for_column(player)
      break if drop_piece(selection, player.symbol)

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
    @previous_move = column_index
    grid.update_column(column_index, symbol)
  end

  def display_grid
    grid.render
  end

  def victory?(player)
    grid.four_in_row?(previous_move, player.symbol) ||
      grid.four_in_column?(previous_move, player.symbol) ||
      grid.four_in_diagonal?(previous_move, player.symbol)
  end

  def draw?
    grid.full?
  end

  def over?(player)
    grid.full? || victory?(player)
  end

  def end_message(player_red, player_black)
    if draw?
      puts "\n It's a draw! Better luck next time! \n\n"
    elsif victory?(player_red)
      puts "\n Player #{player_red.symbol} is the winner! \n\n"
    else
      puts "\n Player #{player_black.symbol} is the winner! \n\n"
    end
  end

  def ending
    system 'clear'
    display_grid
    end_message(player_red, player_black)
  end
end
