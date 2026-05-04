class Player
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end
end

class Cell
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def addPiece(player)
    @value = player.symbol
  end
end
