class PgnsController < ApplicationController

  def new
    @pgn = Pgn.new
  end

  def create
    @pgn = Pgn.new(pgn_params)

    if @pgn.valid?
      game_params = @pgn.game_params

      Game.create(game_params)

      redirect_to root_path
    else
      render :new
    end
  end


  private

  def pgn_params
    params.require(:pgn).permit(:text)
  end
end
