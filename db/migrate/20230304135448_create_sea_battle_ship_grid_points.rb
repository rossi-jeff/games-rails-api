class CreateSeaBattleShipGridPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :sea_battle_ship_grid_points do |t|
      t.string :Horizontal, limit: 1
      t.integer :Vertical
      t.references :sea_battle_ship, null: false, foreign_key: true

      t.timestamps
    end
  end
end
