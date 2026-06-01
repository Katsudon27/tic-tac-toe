require_relative "game_board"
require_relative "player"

# Controls the flow of the Tic Tac Toe game
class GameController
  def initialize(player1, player2, game_board)
    @player1 = player1
    @player2 = player2
    @game_board = game_board
    @current_player = @player1
  end

  def switch_turn
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def player_win?
    player_moves = @game_board.return_player_cells(@current_player)

    if (player_moves.length >= 3) && (check_condition?("row", player_moves) ||
      check_condition?("column", player_moves) ||
      check_condition?("diagonal", player_moves))
      return true
    end

    false
  end

  def draw_game?
    @game_board.return_empty_cells.empty?
  end

  def return_player_input
    @current_player.make_move
  end

  def place_piece(player_move)
    @game_board.place_piece(player_move, @current_player)
  end

  private

  def check_condition?(orientation, player_moves)
    case orientation
    when "row"
      winning_conditions = [%w[1 2 3], %w[4 5 6], %w[7 8 9]]
    when "column"
      winning_conditions = [%w[1 4 7], %w[2 5 8], %w[3 6 9]]
    when "diagonal"
      winning_conditions = [%w[1 5 9], %w[3 5 7]]
    end

    winning_conditions.each do |condition|
      return true if (condition - player_moves).empty?
    end

    false
  end
end
