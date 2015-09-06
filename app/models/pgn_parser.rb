class PgnParser

  def self.parse(pgn, parser = PGN)
    game_pgn = clean(pgn)
    parser.parse(game_pgn).first
    raise "blah"
  end


  private

  def self.clean(pgn)
    pgn.strip!
    pgn.gsub!(/[\u201c|\u201d]/, "\"") #top 2 remove unicode quotation marks
    # pgn.gsub!(/\r/, "") #remove carriage return
    # pgn.gsub!(/\n/, " ") #remove new line
    # pgn.gsub!(/{.*?}/, "") #removes annotation comments
    pgn.gsub!(/\$\d+\s/, "") #removes NAG
    pgn.gsub!(/0-0/, "O-O")
    pgn.gsub!(/0-0-0/, "O-O-O")
    # pgn.gsub!(/\]\s+1/, "]\n1")
    pgn
  end
end