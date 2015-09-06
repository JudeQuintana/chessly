class Game < ActiveRecord::Base

  validates :white, :black, :result, :pgn, :presence => true

end