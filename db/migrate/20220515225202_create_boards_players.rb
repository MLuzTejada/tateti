class CreateBoardsPlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :boards_players do |t|
      t.belongs_to :player
      t.belongs_to :board
      #agregar un game_piece? para saber el jugador en este tablero que ficha tiene
      t.timestamps
    end
  end
end
