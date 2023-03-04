class CreateCodeBreakerCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :code_breaker_codes do |t|
      t.integer :Color
      t.references :code_breaker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
