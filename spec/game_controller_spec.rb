require_relative "../lib/game_controller"

describe GameController do
  describe "#play_game" do
    subject(:game_controller) { described_class.new }

    context "when a player places three pieces across a row" do
      before do
        allow(game_controller).to receive(:print_instructions)
        allow(game_controller).to receive(:play_round).and_return("1", "4", "2", "5", "3")
      end
      it "should end the game" do
        expect(game_controller).to receive(:game_over).once
        game_controller.play_game
      end
    end

    context "when a player places three pieces across a column" do
      before do
        allow(game_controller).to receive(:print_instructions)
        allow(game_controller).to receive(:play_round).and_return("1", "2", "4", "5", "7")
      end
      it "should end the game" do
        expect(game_controller).to receive(:game_over).once
        game_controller.play_game
      end
    end

    context "when a player places three pieces diagonally" do
      before do
        allow(game_controller).to receive(:print_instructions)
        allow(game_controller).to receive(:play_round).and_return("1", "2", "5", "3", "9")
      end
      it "should end the game" do
        expect(game_controller).to receive(:game_over).once
        game_controller.play_game
      end
    end
  end
end
