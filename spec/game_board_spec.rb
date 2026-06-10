require_relative "../lib/game_board"
require_relative "../lib/cell"

describe GameBoard do
  subject(:game_board) { described_class.new }
  let(:player1) { double(Player) }
  let(:board) { game_board.instance_variable_get(:@board) }
  let(:cell2) { board[0][1] }
  describe "#place_piece" do
    context "when a player places a piece on cell 2" do
      before do
        allow(cell2).to receive(:add_piece)
        allow(player1).to receive(:symbol).and_return("O")
      end
      it "should send add_piece to the corresponding cell" do
        expect(cell2).to receive(:add_piece).once
        game_board.place_piece("2", player1)
      end
    end
  end

  describe "#return_empty_cells" do
    before do
      board.each do |row|
        row.each { |cell| allow(cell).to receive(:is_occupied).and_return("X") }
      end
    end

    context "when there are no empty cells left" do
      it "should return an empty array" do
        expect(game_board.return_empty_cells).to eq([])
      end
    end

    context "when there are empty cells left" do
      before do
        allow(cell2).to receive(:is_occupied).and_return(false)
      end
      it "should return an array with the values of the empty cells" do
        expect(game_board.return_empty_cells).to eq(["2"])
      end
    end
  end

  describe "#return_player_cells" do
    before do
      board.each do |row|
        row.each { |cell| allow(cell).to receive(:is_occupied).and_return(false) }
      end

      allow(player1).to receive(:symbol).and_return("X")
    end

    context "when a player has not placed any piece" do
      it "should return an empty array" do
        expect(game_board.return_player_cells(player1)).to eq([])
      end
    end

    context "when the player has placed a piece on cell 2" do
      before do
        allow(cell2).to receive(:is_occupied).and_return("X")
      end
      it "should return an array with the values of the player's cells" do
        expect(game_board.return_player_cells(player1)).to eq(["2"])
      end
    end
  end
end
