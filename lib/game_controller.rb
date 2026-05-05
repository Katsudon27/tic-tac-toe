require_relative "game_board"
require_relative "player"

class GameController
  def initialize
    @game_board = GameBoard.new
    @player1 = Player.new("Player 1", "O")
    @player2 = Player.new("Player 2", "X")
    @currentPlayer = @player1
  end

  def switchPlayerTurn
    @currentPlayer = @currentPlayer == @player1 ? @player2 : @player1
  end

  def checkMoveValidity(cell_num)
    @game_board.returnEmptyCells.include?(cell_num) || false
  end

  def checkCondition(orientation, player_moves)
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
  end

  def checkWin(_player)
    player_moves = @game_board.returnPlayerCells(@currentPlayer)

    if (player_moves.length >= 3) && (checkCondition("row", player_moves) ||
      checkCondition("column", player_moves) ||
      checkCondition("diagonal", player_moves))
      return true
    end

    false
  end

  def playRound
    puts "#{@currentPlayer.name}'s turn: Please choose a valid cell (0 - 9) to place your piece"

    while true
      player_input = gets.chomp
      break if ("1".."9").to_a.include?(player_input) && checkMoveValidity(player_input)

      puts "Invalid input: Please choose an unoccupied cell to place your piece"

    end

    @game_board.placePiece(player_input, @currentPlayer)
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

    while true
      @game_board.printBoard

      playRound

      if checkWin(@currentPlayer)
        @game_board.printBoard
        puts "Congratulations! #{@currentPlayer.name} has won the game!"
        break
      elsif @game_board.returnEmptyCells.length === 0
        @game_board.printBoard
        puts "Oh... it seems like we have a draw!"
        break
      end

      switchPlayerTurn
    end

    puts "GAME OVER"
  end
end
