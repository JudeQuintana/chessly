require "rails_helper"

RSpec.describe Game do
  describe "validations" do
    it { should validate_presence_of(:white) }
    it { should validate_presence_of(:black) }
    it { should validate_presence_of(:result) }
    it { should validate_presence_of(:pgn) }
  end
end