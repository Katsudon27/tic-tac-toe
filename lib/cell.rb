require_relative "player"

class Cell
  @@number_of_cells = 0

  attr_reader :value, :is_occupied

  def initialize
    @@number_of_cells += 1
    @value = @@number_of_cells.to_s
    @is_occupied = false
  end

  def add_piece(player)
    @is_occupied = player.symbol
  end
end
