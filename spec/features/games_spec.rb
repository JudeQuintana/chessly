require "rails_helper"

RSpec.describe "Game" do
  it "shows an empty list of games" do
    visit root_path

    expect(page).to have_content("Game List")
    expect(page).to have_content("No games, try creating one!")
    expect(page).to have_content("White")
    expect(page).to have_content("Black")
    expect(page).to have_content("Result")
  end

  xit "shows a list of existing games" do
  end

  def create_game
    create(:game)
  end

end