require "rails_helper"

RSpec.describe "Game Index" do
  it "shows a list of games" do
    create(:game)

    visit "/"

    expect(page).to have_content("Game List")

  end
end