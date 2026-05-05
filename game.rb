class Player
  attr_reader :symbol, :name

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Cell
  @@number_of_cells = 0

  attr_reader :value, :is_occupied

  def initialize()
    @@number_of_cells += 1
    @value = @@number_of_cells.to_s
    @is_occupied = false
  end

  def addPiece(player)
    @is_occupied = player.symbol
  end
end

class GameBoard
  def initialize()
    
    @board = Array.new(3) {Array.new(3)}
    @board = @board.map do |row|
      row.map do |item|
        item = Cell.new()
      end
    end
  end

  def placePiece(num, player)
    @board = @board.map do |row|
      row.map do |cell|
        if cell.value == num
          cell.addPiece(player)
        end
        cell
      end
    end
  end

  def printBoard
    @board.each do |row|
      puts row.map { |cell| cell.is_occupied === false ? cell.value : cell.is_occupied }.join(" ")
    end
  end

  def returnEmptyCells
    @board.map do |row|
      row.filter do |cell|
        cell.is_occupied === false ? cell.value : next
      end.map {|cell| cell.value}
    end.flatten
  end

  def returnPlayerCells(player)
    @board.map do |row|
      row.filter do |cell|
        cell.is_occupied === player.symbol ? cell.value : next
      end.map {|cell| cell.value}
    end.flatten
  end
end

class GameController
  def initialize()
    @game_board = GameBoard.new()
    @player1 = Player.new("Player 1", "O")
    @player2 = Player.new("Player 2", "X")
    @currentPlayer = @player1
  end

  def switchPlayerTurn()
    @currentPlayer = @currentPlayer == @player1 ? @player2 : @player1
  end

  def checkMoveValidity(cell_num)
    @game_board.returnEmptyCells().include?(cell_num) ? true : false
  end

  def checkWin(player)
    player_moves = @game_board.returnPlayerCells(@currentPlayer)
    
    if player_moves.length >= 3
      winning_conditions_row = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
      winning_conditions_column = [["1", "4", "7"], ["2", "5", "8"], ["3", "6", "9"]]
      winning_conditions_diagonal = [["1", "5", "9"], ["3", "5", "7"]]

      winning_conditions_row.each do |condition|
        if (condition - player_moves).empty?
          return true
        end
      end

      winning_conditions_column.each do |condition|
        if (condition - player_moves).empty?
          return true
        end
      end

      winning_conditions_diagonal.each do |condition|
        if (condition - player_moves).empty?
          return true
        end
      end
    end

    return false
  end

  def playRound
    puts "#{@currentPlayer.name}'s turn: Please choose a valid cell (0 - 9) to place your piece"

    while true
      player_input = gets.chomp
      if ("1".."9").to_a.include?(player_input) && checkMoveValidity(player_input)
        break
      else
        puts "Invalid input: Please choose a valid cell (0 - 9) to place your piece"
      end
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
      puts "Current TIC-TAC-TOE game board"
      @game_board.printBoard()
      puts "------"

      playRound()

      if checkWin(@currentPlayer)
        @game_board.printBoard()
        puts "Congratulations! #{@currentPlayer.name} has won the game!"
        break
      elsif @game_board.returnEmptyCells().length === 0
        @game_board.printBoard()
        puts "Oh... it seems like we have a draw!"
        break
      end

      switchPlayerTurn()
    end

    puts "GAME OVER"
  end
end

game = GameController.new()
game.start_game()
