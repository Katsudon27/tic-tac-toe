require_relative "game_board"
require_relative "player"

class GameController
  def initialize
    @game_board = GameBoard.new
    @player1 = Player.new("Player 1", "O")
    @player2 = Player.new("Player 2", "X")
    @current_player = @player1
  end

  def switch_turn
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def check_move_validity?(cell_num)
    @game_board.return_empty_cells.include?(cell_num) || false
  end

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

  def check_win?
    player_moves = @game_board.return_player_cells(@current_player)
    puts "#{@current_player.name}'s moves: #{player_moves}"

    if (player_moves.length >= 3) && (check_condition?("row", player_moves) ||
      check_condition?("column", player_moves) ||
      check_condition?("diagonal", player_moves))
      return true
    end

    false
  end

  def play_round
    puts "#{@current_player.name}'s turn: Please choose a valid cell (0 - 9) to place your piece"

    while true
      player_input = gets.chomp
      break if ("1".."9").to_a.include?(player_input) && check_move_validity?(player_input)

      puts "Invalid input: Please choose an unoccupied cell to place your piece"

    end

    @game_board.place_piece(player_input, @current_player)
  end

  def start_game
    puts "Console-based TIC-TAC-TOE game"
    puts "######"
    puts "Prior to playing the game, please decide among yourselves to be Player 1 or Player 2"
    puts "- Player 1 will be represented by the mark 'O'"
    puts "- Player 2 will be represented by the mark 'X'"
    puts "######"
    puts "The goal for both players is to mark all three cells of a row, columns, or diagonal of the grid."
    puts "######"
    puts "START GAME"

    loop do
      @game_board.print_board

      play_round

      if check_win?
        @game_board.print_board
        puts "Congratulations! #{@current_player.name} has won the game!"
        break
      elsif @game_board.return_empty_cells.empty?
        @game_board.print_board
        puts "Oh... it seems like we have a draw!"
        break
      end

      switch_turn
    end

    puts "GAME OVER"
  end
end
