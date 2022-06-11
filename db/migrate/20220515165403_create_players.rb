class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :password
      t.string :token
      t.integer :score, default: 0
      t.string :color
      t.string :piece
      t.timestamps
    end
  end
end
