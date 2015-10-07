class GamesRemovePgnNotNull < ActiveRecord::Migration
  def change
    change_column_null :games, :pgn, true
  end
end
