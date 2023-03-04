class AddWordRefToGuessWord < ActiveRecord::Migration[7.0]
  def change
    add_reference :guess_words, :word, null: false, foreign_key: true
  end
end
