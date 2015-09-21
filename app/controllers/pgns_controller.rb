class PgnsController < ApplicationController

  def new
    @pgn = Pgn.new
  end

  def create
    @pgn = Pgn.new(pgn_params)

    if @pgn.save
      redirect_to root_path, :notice => "Game Saved!"
    else
      render :new
    end
  end


  private

  def pgn_params
    params.require(:pgn).permit(:text)
  end
end
