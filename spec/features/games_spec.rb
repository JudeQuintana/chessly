require "rails_helper"

RSpec.describe "Game Index" do
  it "shows a list of games" do
    create(:game)

    visit root_path

    expect(page).to have_content("Game List")

  end
end