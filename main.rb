require_relative "lib/game_controller"
require_relative "lib/game_board"
require_relative "lib/player"

def print_instructions
  puts "Console-based TIC-TAC-TOE game"
  puts "######"
  puts "Prior to playing the game, please decide among yourselves to be Player 1 or Player 2"
  puts "- Player 1 will be represented by the mark 'O'"
  puts "- Player 2 will be represented by the mark 'X'"
  puts "######"
  puts "The goal for both players is to mark all three cells of a row, columns, or diagonal of the grid."
  puts "######"
  puts "START GAME"
end

print_instructions

game_board = GameBoard.new
player1 = Player.new("Player 1", "O")
player2 = Player.new("Player 2", "X")
game_controller = GameController.new(player1, player2, game_board)

loop do
  game_board.print_board
  player_move = game_controller.return_player_input

  unless ("1".."9").to_a.include?(player_move)
    puts "Invalid input: Please enter a valid cell number"
    redo
  end

  unless game_board.return_empty_cells.include?(player_move)
    puts "Invalid input: Please choose an unoccupied cell to place your piece"
    redo
  end

  game_controller.place_piece(player_move)

  if game_controller.player_win?
    game_board.print_board
    puts "Congratulations! #{game_controller.current_player.name} has won the game!"
    break
  elsif game_controller.draw_game?
    game_board.print_board
    puts "Oh... it seems like we have a draw!"
    break
  end

  game_controller.switch_turn
end
