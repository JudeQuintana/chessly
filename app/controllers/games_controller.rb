class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def new

  end

  def create
  end

  def show
  end

  def destroy
  end

end