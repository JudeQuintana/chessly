class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to root_path, :notice => "Game Deleted!"
  end


  private

  def game_params
    params.permit(:game_params)
  end
end