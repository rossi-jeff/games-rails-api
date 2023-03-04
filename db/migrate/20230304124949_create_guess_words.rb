class CreateGuessWords < ActiveRecord::Migration[7.0]
  def change
    create_table :guess_words do |t|
      t.integer :Status, default: 1
      t.integer :Score, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
