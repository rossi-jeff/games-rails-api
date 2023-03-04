class CreateSeaBattleShips < ActiveRecord::Migration[7.0]
  def change
    create_table :sea_battle_ships do |t|
      t.integer :Type
      t.integer :Navy
      t.integer :Size
      t.boolean :Sunk, default: false
      t.references :sea_battle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
