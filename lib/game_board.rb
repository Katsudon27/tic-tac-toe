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

  def place_piece(num, player)
    @board = @board.map do |row|
      row.map do |cell|
        cell.add_piece(player) if cell.value == num
        cell
      end
    end
  end

  def print_board
    puts "------"
    puts "Current TIC-TAC-TOE game board"
    @board.each do |row|
      puts row.map { |cell| cell.is_occupied === false ? cell.value : cell.is_occupied }.join("  ")
    end
    puts "------"
  end

  def return_empty_cells
    @board.map do |row|
      row.filter do |cell|
        cell.is_occupied == false ? cell.value : next
      end.map(&:value)
    end.flatten
  end

  def return_player_cells(player)
    @board.map do |row|
      row.filter do |cell|
        cell.is_occupied == player.symbol ? cell.value : next
      end.map(&:value)
    end.flatten
  end
end
