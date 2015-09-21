class Pgn
  include ActiveModel::Model

  attr_accessor :text, :game_params

  validates :text, :presence => true
  validate :check_pgn!

  def initialize(attrs = {}, pgn_parser = PGN)
    self.pgn_parser = pgn_parser
    super(attrs)
  end


  private

  attr_accessor :pgn_parser

  def check_pgn!
    begin
      clean!
      pgn_game = pgn_parser.parse(text).first
      build_game_params!(pgn_game)
    rescue
      errors.add(:pgn, "could not be parsed, please check your formatting.")
    end
  end

  def clean!
    text.gsub!(/[\u201c|\u201d]/, "\"") #replace unicode quotation marks
    text.gsub!(/\$\d+\s/, "") #removes NAG
    text.gsub!(/\r/, "") #remove carriage return
    text.gsub!(/\n/, " ") #replace new line with space
  end

  def build_game_params!(pgn_game)
    self.game_params = { :white  => pgn_game.tags.fetch("White"),
                         :black  => pgn_game.tags.fetch("Black"),
                         :result => pgn_game.tags.fetch("Result"),
                         :pgn    => text }
  end
end