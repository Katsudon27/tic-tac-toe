require_relative "player"

class Cell
  attr_reader :value, :is_occupied

  def initialize(num)
    @value = num.to_s
    @is_occupied = false
  end

  def add_piece(player)
    @is_occupied = player.symbol
  end
end
