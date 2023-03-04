class CreateCodeBreakers < ActiveRecord::Migration[7.0]
  def change
    create_table :code_breakers do |t|
      t.integer :Status, default: 1
      t.integer :Columns
      t.integer :Colors
      t.integer :Score, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
