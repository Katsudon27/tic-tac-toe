require_relative "cell"

class GameBoard
  def initialize
    @board = Array.new(3) { Array.new(3) }
    @board = @board.map do |row|
      row.map do |_item|
        Cell.new
      end
    end
  end

  def placePiece(num, player)
    @board = @board.map do |row|
      row.map do |cell|
        cell.addPiece(player) if cell.value == num
        cell
      end
    end
  end

  def printBoard
    puts "------"
    puts "Current TIC-TAC-TOE game board"
    @board.each do |row|
      puts row.map { |cell| cell.is_occupied === false ? cell.value : cell.is_occupied }.join("  ")
    end
    puts "------"
  end

  def returnEmptyCells
    @board.map do |row|
      row.filter do |cell|
        cell.is_occupied == false ? cell.value : next
      end.map { |cell| cell.value }
    end.flatten
  end

  def returnPlayerCells(player)
    @board.map do |row|
      row.filter do |cell|
        cell.is_occupied == player.symbol ? cell.value : next
      end.map { |cell| cell.value }
    end.flatten
  end
end
