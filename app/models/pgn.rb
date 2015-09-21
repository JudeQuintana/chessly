class Pgn
  include ActiveModel::Model

  attr_accessor :text

  validates :text, :presence => true
  validate :check_pgn!, :if => :text_present?

  def initialize(attrs = {}, pgn_parser = PGN)
    self.pgn_parser = pgn_parser
    super(attrs)
  end

  def save
    return false unless valid?
    game = Game.new(game_params)
    if game.save
      true
    else
      add_errors_from_game!(game)
      false
    end
  end

  private

  attr_accessor :pgn_parser, :game_params

  def check_pgn!
    begin
      pgn_text = clean!
      pgn_game = pgn_parser.parse(pgn_text).first
    rescue
      could_not_be_parsed!
      return
    end

    build_game_params!(pgn_game, pgn_text)
  end

  def clean!
    pgn_text = text.dup
    pgn_text.strip! #remove carriage return
    pgn_text.gsub(/[\u201c|\u201d]/, "\"") #replace unicode quotation marks
    pgn_text.gsub!(/\$\d+\s/, "") #removes NAG
    pgn_text.gsub!(/\n/, " ") #replace new line with space
    pgn_text
  end

  def build_game_params!(pgn_game, pgn_text)
    self.game_params = { :white  => pgn_game.tags["White"],
                         :black  => pgn_game.tags["Black"],
                         :result => pgn_game.tags["Result"],
                         :pgn    => pgn_text }
  end

  def add_errors_from_game!(game)
    game.errors.messages.each do |err_key, err_msg|
      errors.add(err_key, err_msg.first)
    end
  end

  def text_present?
    text.present?
  end

  def could_not_be_parsed!
    errors.add(:pgn, "could not be parsed, please check your formatting.")
  end
end