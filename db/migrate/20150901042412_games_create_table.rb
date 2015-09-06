class GamesCreateTable < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :event
      t.string :site
      t.string :round
      t.string :date
      t.string :white, :null => false
      t.string :black, :null => false
      t.string :result, :null => false
      t.text :pgn, :null => false
      t.text :notes
      t.timestamps :null => false
    end
  end
end
