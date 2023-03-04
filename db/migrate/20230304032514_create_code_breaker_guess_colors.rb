class CreateCodeBreakerGuessColors < ActiveRecord::Migration[7.0]
  def change
    create_table :code_breaker_guess_colors do |t|
      t.integer :Color
      t.references :code_breaker_guess, null: false, foreign_key: true

      t.timestamps
    end
  end
end
