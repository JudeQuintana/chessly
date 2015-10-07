require "rails_helper"

RSpec.describe Game do
  describe "validations" do
    it { should validate_presence_of(:white) }
    it { should validate_presence_of(:black) }
    it { should validate_presence_of(:result) }
  end

  describe "#moves" do
    it "returns only the moves from the pgn" do
      moves = '1.e4 c5 2.Nf3 Nc6 3.d4 cxd4 4.Nxd4 e6 5.Nc3 d6 6.Be3 Nf6 7.f4 '\
              'Be7 8.Qf3 O-O 9.O-O-O Qc7 10.Ndb5 Qb8 11.g4 a6 12.Nd4 Nxd4 '\
              '13.Bxd4 b5 14.g5 Nd7 15.Bd3 b4 16.Nd5 exd5 17.exd5 f5 18.Rde1 Rf7 '\
              '19.h4 Bb7 20.Bxf5 Rxf5 21.Rxe7 Ne5 22.Qe4 Qf8 23.fxe5 Rf4 '\
              '24.Qe3 Rf3 25.Qe2 Qxe7 26.Qxf3 dxe5 27.Re1 Rd8 28.Rxe5 Qd6 '\
              '29.Qf4 Rf8 30.Qe4 b3 31.axb3 Rf1+ 32.Kd2 Qb4+ 33.c3 Qd6 '\
              '34.Bc5 Qxc5 35.Re8+ Rf8 36.Qe6+ Kh8 37.Qf7'\

      game = create(:game)

      expect(game.moves).to eq(moves)
    end
  end
end