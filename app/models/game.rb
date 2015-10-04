class Game < ActiveRecord::Base

  validates :white, :black, :result, :pgn, :presence => true

  def moves
    match_moves = pgn.match(/]\s+(1\..*)\s\d-\d/)[1]
    match_moves.gsub!(/\s{.*?}/,"") #remove comments
    match_moves.gsub!(/\s\(.*?\)/,"") #remove variations
    match_moves
  end
end