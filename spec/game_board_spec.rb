require_relative "../lib/game_board"
require_relative "../lib/cell"

describe GameBoard do
  subject(:game_board) { described_class.new }
  describe "#place_piece" do
    let(:player1) { instance_double(Player) }
    let(:cell2) { game_board.instance_variable_get(:@board)[0][1] }

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
end
