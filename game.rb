class Player
  attr_reader :symbol

  def initialize(symbol)
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

#test = GameBoard.new()
#test.printBoard

#player1 = Player.new("X")
#test.placePiece("1", player1)
#test.printBoard
