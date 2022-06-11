class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :token
      t.string :turn, default: 'X'
      t.integer :winner
      t.string :squares, array: true
      t.string :colors, array: true
      t.boolean :tie, default: false
      t.timestamps
    end
  end
end
