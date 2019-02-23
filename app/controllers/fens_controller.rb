class FensController < ApplicationController

  def show
    game = Game.find(params[:game_id])

    build_fen = PGN.parse("[Dummy \"Tag\"]" + game[:pgn]).first
    build_fen.positions.delete_at(0)

    @fen_hsh = []
    build_fen.positions.each_with_index.inject(1) do |counter, (pos, index)|
      # Parser Generates an incorrect "Fullmove number" thats starts at 0
      # should start at one
      fen = pos.to_fen.to_s[0...-1] + counter.to_s
      @fen_hsh << fen
      counter += 1
    end


    respond_to do |format|
      format.json { render json: @fen_hsh }
    end

  end

end
