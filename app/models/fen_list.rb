class FenList
  attr_accessor :game, :list

  def self.for_game(game)
    new(:game => game).generate!
  end

  def initialize(attrs, pgn_parser = PGN)
    self.pgn_parser = pgn_parser
    self.game       = attrs.fetch(:game)
    self.list       = {}
  end

  def generate!
    pgn = pgn_parser.parse(game.pgn).first

    positions = pgn.positions[1..-1]

    positions.each_with_index.inject(1) do |move_number, (position, index)|

      if index % 2 == 1
        list["#{move_number}"].push(position.to_fen.to_s)
        move_number +=1
      elsif index % 2 == 0 #even
        list["#{move_number}"] = [position.to_fen.to_s]
      end

      move_number
    end

    list
  end


  private

  attr_accessor :pgn_parser
end