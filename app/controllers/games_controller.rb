class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    pgn = PgnValidator.new(pgn_params)

    if pgn.valid?
      game = pgn.game
      Game.create!(game_params(game))

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

  def game_params(game)
    tags = game.tags
    { :white  => tags.fetch("White"),
      :black  => tags.fetch("Black"),
      :result => tags.fetch("Result"),
      :pgn    => pgn_params }
  end

end