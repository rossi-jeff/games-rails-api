class CreateKlondikes < ActiveRecord::Migration[7.0]
  def change
    create_table :klondikes do |t|
      t.integer :Status
      t.integer :Moves
      t.integer :Elapsed
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
