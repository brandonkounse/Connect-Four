# frozen_string_literal: true

# Singleton for calling instructions for Connect Four
class Instructions
  def self.start
    system 'clear'
    puts <<~HEREDOC
      In Connect Four, the game is won by getting 4 pieces in a row. The row can be horizontal, vertical, or diagonal. There are two colored pieces in this version, red and black. Good luck!

      Enter [1] to start a new game of Connect Four, or type [2] to exit.
    HEREDOC
  end

  def self.turn(player)
    print "\n\nChoose a column to drop piece #{player.symbol} : "
  end
end
