class CreateHangMen < ActiveRecord::Migration[7.0]
  def change
    create_table :hang_men do |t|
      t.string :Correct, default: ''
      t.string :Wrong, default: ''
      t.integer :Status, default: 1
      t.integer :Score, default: 0
      t.references :user, foreign_key: true
      t.references :word, null: false, foreign_key: true

      t.timestamps
    end
  end
end
