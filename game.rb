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
    @value = player.symbol
    @is_occupied = true
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
      puts row.map { |cell| cell.value }.join(" ")
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
        cell.value === player.symbol
      end.map {|cell| cell.value}
    end.flatten
  end
end

class GameController
  def initialize()
    @game_board = GameBoard.new()
    @player1 = player.new("Player 1", "O")
    @player2 = player.new("Player 2", "X")
    @currentPlayer = @player1
  end

  def switchPlayerTurn()
    @currentPlayer = @currentPlayer == @player1 ? @player2 : @player1
  end

  def printNewRound
    @game_board.printBoard()
    puts "#{@currentPlayer.name}'s turn: Please choose a valid cell (0 - 9) to place your piece"
  end

  def checkMoveValidity(cell_num)
    @game_board.returnEmptyCells().include?(cell_num) ? true : false
  end

  def checkWin(player)
    player_moves = @board.returnPlayerCells()
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

    return false
  end
end
