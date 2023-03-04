class CreateCodeBreakerGuessKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :code_breaker_guess_keys do |t|
      t.integer :Key
      t.references :code_breaker_guess, null: false, foreign_key: true

      t.timestamps
    end
  end
end
