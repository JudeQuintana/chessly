class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    pgn = ::Utils::Pgn.new(pgn_params)

    if pgn.valid?
      game = pgn.game

      game.save!

      redirect_to root_path
    else
      @game = pgn
      render :new
    end
  end

  def show
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to root_path, :notice => "Game Deleted!"
  end


  private

  def default_params
    { :text => "" }
  end

  def pgn_params
    params.permit(:text)
  end
end