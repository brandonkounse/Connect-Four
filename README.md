###Connect Four

Connect Four is a game where each player takes turns picking a column to drop their respective colored piece into. To win a game of Connect Four, a player must get 4 matching colored pieces either horizontally, vertically, or diagonally.

To start a game, either run the main file via `ruby lib/main.rb` from the game's directory or writing the script yourself:

```ruby
  require_relative 'ConnectFour'

  game = ConnectFour.new
  game.start
```

There are only two players in Connect Four, and in this version their colors are pre-defined:

```ruby
  player_red = 🔴
  player_black = ⚫
```

The game defines available spaces as:
```ruby
EMPTY_SPOTS = ⚪
```
which works very well for formatting the Connect Four Grid.

The game will continue to loop until one player is the victor, or if the game is a draw. For more information on Connect Four, see [Connect Four Wikipedia](https://en.wikipedia.org/wiki/Connect_Four).
