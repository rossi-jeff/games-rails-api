class CreateFreeCells < ActiveRecord::Migration[7.0]
  def change
    create_table :free_cells do |t|
      t.integer :Status, default: 1
      t.integer :Moves, default: 0
      t.integer :Elapsed, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
