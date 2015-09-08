class PgnValidator
  include ActiveModel::Model

  attr_accessor :pgn_text, :game

  validates :pgn_text, :presence => true
  validate :check_pgn

  def initialize(attributes, pgn_parser = PGN)
    self.pgn_parser = pgn_parser
    super(attributes)
  end


  private

  attr_accessor :pgn_parser

  def check_pgn
    begin
      clean!
      self.game = pgn_parser.parse(pgn_text).first
    rescue
      errors.add(:pgn, "could not be parsed, please check your formatting.")
    end
  end

  def clean!
    pgn_text.strip!
    pgn_text.gsub!(/[\u201c|\u201d]/, "\"") #top 2 remove unicode quotation marks
    pgn_text.gsub!(/\$\d+\s/, "") #removes NAG
  end
end