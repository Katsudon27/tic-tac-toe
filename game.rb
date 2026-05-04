class Player
  attr_reader :symbol, :name

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Cell
  @@number_of_cells = 0

  attr_reader :value

  def initialize()
    @@number_of_cells += 1
    @value = @@number_of_cells.to_s
  end

  def addPiece(player)
    @value = player.symbol
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
end

#test = GameBoard.new()
#test.printBoard

#player1 = Player.new("X")
#test.placePiece("1", player1)
#test.printBoard
