require "rails_helper"

RSpec.describe "Games" do

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
    '1.e4 c5 2.Nf3 Nc6 3.d4 cxd4 4.Nxd4 e6 5.Nc3 d6 6.Be3 Nf6 7.f4 '\
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
    '1.e4 c5 2.Nf3 Nc6 3.d4 cxd4 4.Nxd4 e6 5.Nc3 d6 6.Be3 Nf6 7.f4 '\
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
    '34.Bc5 Qxc5 35.Re8+ Rf8 36.Qe6+ Kh8 37.Qf7 1-0'\
  }

  context "no games" do
    it "shows an empty list of games" do
      visit root_path

      expect(page).to have_content("Game List")
      expect(page).to have_content("No games, try creating one!")
      expect(page).to have_content("White")
      expect(page).to have_content("Black")
      expect(page).to have_content("Result")
    end
  end

  context "existing games" do
    it "shows a list of games" do
      create_game

      visit root_path

      expect(page).to have_content("Mikhail Tal")
      expect(page).to have_content("Bent Larson")
      expect(page).to have_content("1-0")
    end
  end

  describe "user creates game" do
    context "valid game" do
      it "creates a game from a pgn example", :js => true do
        visit root_path
        click_on "Create Game"

        expect(page).to have_content("Copy/Paste PGN")
        expect(page).to have_content("Example")

        click_on "Example"
        click_on "Submit"

        expect(page).to have_content("Mikhail Tal")
      end

      it "create game from pasted pgn" do
        visit root_path
        click_on "Create Game"

        fill_in :pgn_text, :with => valid_pgn
        click_on "Submit"

        expect(page).to have_content("Mikhail Tal")
      end
    end

    context "invalid game" do
      it "shows errors" do
        visit root_path
        click_on "Create Game"
        click_on "Submit"
        expect(page).to have_content("Text can't be blank")

        fill_in :pgn_text, :with => "blah"
        click_on "Submit"
        expect(page).to have_content("Pgn could not be parsed, please check your formatting.")
      end
    end
  end

  describe "user can delete a game" do
    it "deletes a game" do
      create_game
      visit root_path

      expect(page).to have_content("Mikhail Tal")
      page.find(".remove-game").click
      expect(page).to have_content("Game Deleted!")
      expect(page).to_not have_content("Mikhail Tal")
    end
  end

  def create_game
    create(:game)
  end
end