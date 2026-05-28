class Player
  attr_reader :symbol, :name

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def make_move
    puts "#{@name}'s turn: Please choose a valid cell (0 - 9) to place your piece"

    gets.chomp
  end
end
