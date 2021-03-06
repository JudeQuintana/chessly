class Pgn
  include ActiveModel::Model

  attr_accessor :text

  validates :text, :presence => true
  validate :check_format!

  def initialize(attrs = {}, parser = PGN)
    self.parser = parser
    super(attrs)
  end

  def save
    return false unless valid?
    Game.create!(game_params)
    true
  end


  private

  attr_accessor :parser, :game_params, :pgn_game

  def check_format!
    return if text.blank?

    begin
      clean!
      self.pgn_game = parser.parse(text).first
    rescue
      could_not_be_parsed!
      return
    end

    build_game_params!
    check_game_params!
  end

  def clean!
    text.strip! #remove white space from ends of string
    text.gsub!(/[\u201c|\u201d]/, "\"") #replace unicode quotation marks
    text.gsub!(/\$\d+\s/, "") #removes NAG
    text.gsub!(/;/, "") #remove semi-colon
  end

  def build_game_params!
    self.game_params = { :white  => pgn_game.tags["White"],
                         :black  => pgn_game.tags["Black"],
                         :result => pgn_game.tags["Result"],
    }
  end

  def check_game_params!
    game = new_game(game_params)
    if !game.valid?
      add_errors_from_game(game)
    else
      text.gsub!(/\r/, "") #removes carriage return
      text.gsub!(/\n/, " ") #replace new line with space
      self.game_params = game_params.merge(:pgn => text)
    end
  end

  def new_game(game_params)
    Game.new(game_params)
  end

  def add_errors_from_game(game)
    game.errors.messages.each do |err_key, err_msg|
      errors.add(err_key, err_msg.first)
    end
  end

  def could_not_be_parsed!
    errors.add(:pgn, "could not be parsed, please check your formatting.")
  end
end