require "rails_helper"

module Utils
  RSpec.describe Pgn do

    let!(:valid_pgn) {
      '[Event "Tal - Larsen Candidates Semifinal"]'\
      '[Site "Bled YUG"]'\
      '[Date "1965.08.08"]'\
      '[EventDate "1965.07.23"]'\
      '[Round "10"]'\
      '[White "Mikhail Tal"]'\
      '[Black "Bent Larsen"]'\
      '[Result "1-0"]'\
      '[ECO "B82"]'\
      '[WhiteElo "?"]'\
      '[BlackElo "?"]'\
      '[MovePly "73"]'\
      '1.e4 (1.e3) c5 (1... c6) 2.Nf3 Nc6 3.d4 cxd4 4.Nxd4 e6 5.Nc3 d6 6.Be3 Nf6 7.f4 '\
      'Be7 8.Qf3 O-O 9.O-O-O Qc7 10.Ndb5 Qb8 11.g4 a6 12.Nd4 Nxd4 '\
      '13.Bxd4 b5 14.g5 Nd7 15.Bd3 b4 16.Nd5 {!} exd5 17.exd5 {The '\
      'piece sacrifice is a positional one, since it has been used to '\
      'erect an invisible barrier on the e-file. A number of squares '\
      'on it (e5 and e6) are controlled by white pawns, and a white '\
      'rook will soon be moved to e1. -- Iakov Damsky} f5 18.Rde1 Rf7 '\
      '19.h4 Bb7 20.Bxf5 Rxf5 21.Rxe7 Ne5 22.Qe4 Qf8 23.fxe5 Rf4 '\
      '24.Qe3 Rf3 25.Qe2 Qxe7 26.Qxf3 dxe5 27.Re1 Rd8 28.Rxe5 Qd6 '\
      '29.Qf4 {! With this simple tactic 29 ...Bxd5 30. Re8+ White '\
      'keeps his two extra pawns. The finish is straightforward. -- '\
      'Damsky} Rf8 30.Qe4 b3 31.axb3 Rf1+ 32.Kd2 Qb4+ 33.c3 Qd6 '\
      '34.Bc5 Qxc5 35.Re8+ Rf8 36.Qe6+ Kh8 37.Qf7 1-0'
    }

    let!(:invalid_pgn) {
      '[Event "Tal - Larsen Candidates Semifinal"]'\
      '[Site "Bled YUG"]'\
      '[Date "1965.08.08"]'\
      '[EventDate "1965.07.23"]'\
      '[Round "10"]'\
      '[White "Mikhail Tal"'\
      '[Black "Bent Larsen"]'\
      '[Result "1-0"]'\
      '[ECO "B82"]'\
      '[WhiteElo "?"]'\
      '[BlackElo "?"]'\
      '[MovePly "73"]'\
      '1.e4 (1.e3) c5 (1... c6) 2.Nf3 Nc6 3.d4 cxd4 4.Nxd4 e6 5.Nc3 d6 6.Be3 Nf6 7.f4 '\
      'Be7 8.Qf3 O-O 9.O-O-O Qc7 10.Ndb5 Qb8 11.g4 a6 12.Nd4 Nxd4 '\
      '13.Bxd4 b5 14.g5 Nd7 15.Bd3 b4 16.Nd5 {!} exd5 17.exd5 {The '\
      'piece sacrifice is a positional one, since it has been used to '\
      'erect an invisible barrier on the e-file. A number of squares '\
      'on it (e5 and e6) are controlled by white pawns, and a white '\
      'rook will soon be moved to e1. -- Iakov Damsky} f5 18.Rde1 Rf7 '\
      '19.h4 Bb7 20.Bxf5 Rxf5 21.Rxe7 Ne5 22.Qe4 Qf8 23.fxe5 Rf4 '\
      '24.Qe3 Rf3 25.Qe2 Qxe7 26.Qxf3 dxe5 27.Re1 Rd8 28.Rxe5 Qd6 '\
      '29.Qf4 {! With this simple tactic 29 ...Bxd5 30. Re8+ White '\
      'keeps his two extra pawns. The finish is straightforward. -- '\
      'Damsky} Rf8 30.Qe4 b3 31.axb3 Rf1+ 32.Kd2 Qb4+ 33.c3 Qd6 '\
      '34.Bc5 Qxc5 35.Re8+ Rf8 36.Qe6+ Kh8 37.Qf7 1-0'
    }

    let!(:valid_pgn_no_white_black_result) {
      '[Event "Tal - Larsen Candidates Semifinal"]'\
      '[Site "Bled YUG"]'\
      '[Date "1965.08.08"]'\
      '[EventDate "1965.07.23"]'\
      '[Round "10"]'\
      '[ECO "B82"]'\
      '[WhiteElo "?"]'\
      '[BlackElo "?"]'\
      '[MovePly "73"]'\
      '1.e4 (1.e3) c5 (1... c6) 2.Nf3 Nc6 3.d4 cxd4 4.Nxd4 e6 5.Nc3 d6 6.Be3 Nf6 7.f4 '\
      'Be7 8.Qf3 O-O 9.O-O-O Qc7 10.Ndb5 Qb8 11.g4 a6 12.Nd4 Nxd4 '\
      '13.Bxd4 b5 14.g5 Nd7 15.Bd3 b4 16.Nd5 {!} exd5 17.exd5 {The '\
      'piece sacrifice is a positional one, since it has been used to '\
      'erect an invisible barrier on the e-file. A number of squares '\
      'on it (e5 and e6) are controlled by white pawns, and a white '\
      'rook will soon be moved to e1. -- Iakov Damsky} f5 18.Rde1 Rf7 '\
      '19.h4 Bb7 20.Bxf5 Rxf5 21.Rxe7 Ne5 22.Qe4 Qf8 23.fxe5 Rf4 '\
      '24.Qe3 Rf3 25.Qe2 Qxe7 26.Qxf3 dxe5 27.Re1 Rd8 28.Rxe5 Qd6 '\
      '29.Qf4 {! With this simple tactic 29 ...Bxd5 30. Re8+ White '\
      'keeps his two extra pawns. The finish is straightforward. -- '\
      'Damsky} Rf8 30.Qe4 b3 31.axb3 Rf1+ 32.Kd2 Qb4+ 33.c3 Qd6 '\
      '34.Bc5 Qxc5 35.Re8+ Rf8 36.Qe6+ Kh8 37.Qf7 1-0'
    }

    describe "parsing" do
      context "invalid PGN" do
        it "generates errors" do
          pgn = Pgn.new(:text => invalid_pgn)

          expect(pgn.save).to eq(false)
          expect(pgn.errors).to include(:pgn)
        end

        it "generates errors for blank pgn" do
          pgn = Pgn.new(:text => "")

          expect(pgn.save).to eq(false)
          expect(pgn.errors).to include(:text)
        end
      end

      context "valid PGN" do
        it "returns true and doesnt have errors" do
          pgn = Pgn.new(:text => valid_pgn)

          expect(pgn.save).to eq(true)
          expect(pgn.errors.any?).to eq(false)
        end

        it "saves game with valid pgn" do
          pgn = Pgn.new(:text => valid_pgn)

          expect(pgn.save).to eq(true)

          game = Game.last
          expect(game.white).to eq("Mikhail Tal")
          expect(game.black).to eq("Bent Larsen")
          expect(game.result).to eq("1-0")
          expect(game.pgn).to eq(valid_pgn)
        end

        it "generates errors for valid pgn but no white, black, or result fields exist" do
          pgn = Pgn.new(:text => valid_pgn_no_white_black_result)

          expect(pgn.valid?).to eq(false)
          expect(pgn.save).to eq(false)
          expect(pgn.errors).to include(:white, :black, :result)
        end
      end
    end
  end
end