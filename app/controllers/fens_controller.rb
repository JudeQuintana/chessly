class FensController < ApplicationController

  def show

    @fen_hsh = {}

    game = Game.find(params[:game_id])

    hsh_i = 1
    build_fen = PGN.parse("[Dummy \"Tag\"]" + game[:pgn]).first
    build_fen.positions.delete_at(0)
    build_fen.positions.each_with_index.inject(1) do |counter, (pos, index)|

      fen = pos.to_fen.to_s[0...-1] + counter.to_s

      if index % 2 == 0 #even
        @fen_hsh[hsh_i] = [fen]
      elsif index % 2 == 1
        @fen_hsh[hsh_i].push(fen)
        hsh_i +=1
      end

      counter += 1

    end


    respond_to do |format|
      format.json { render json: @fen_hsh }
    end

  end

end
