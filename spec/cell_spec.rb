require_relative "../lib/cell"

describe Cell do
  subject(:cell) { described_class.new(1) }
  describe "#add_piece" do
    context "when the player's symbol is X" do
      let(:player1) { double(Player) }
      before do
        allow(player1).to receive(:symbol).and_return("X")
      end
      it "updates @is_occupied to the player's symbol" do
        cell.add_piece(player1)
        expect(cell.is_occupied).to eq("X")
      end
    end
  end
end
