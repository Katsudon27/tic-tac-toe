require_relative "../lib/game_controller"
require_relative "../lib/game_board"
require_relative "../lib/player"

describe GameController do
  let(:player1) { instance_double(Player) }
  let(:player2) { instance_double(Player) }
  let(:game_board) { instance_double(GameBoard) }
  subject(:game_controller) { described_class.new(player1, player2, game_board) }

  describe "#player_win?" do
    context "when a player places three pieces across a row" do
      before do
        allow(game_controller).to receive(:current_player_cells).and_return(%w[1 2 3])
      end
      it "should return true" do
        expect(game_controller.player_win?).to be true
      end
    end

    context "when a player places three pieces across a column" do
      before do
        allow(game_controller).to receive(:current_player_cells).and_return(%w[1 4 7])
      end
      it "should return true" do
        expect(game_controller.player_win?).to be true
      end
    end

    context "when a player places three pieces diagonally" do
      before do
        allow(game_controller).to receive(:current_player_cells).and_return(%w[1 5 9])
      end
      it "should return true" do
        expect(game_controller.player_win?).to be true
      end
    end

    context "when a player has not yet won" do
      before do
        allow(game_controller).to receive(:current_player_cells).and_return(%w[1 3])
      end
      it "should return false" do
        expect(game_controller.player_win?).to be false
      end
    end
  end

  describe "#switch_turn" do
    it "should switch to the other player as the current player" do
      game_controller.switch_turn
      expect(game_controller.current_player).to eq(player2)
    end
  end
end
