class AddAvailableToCodeBreaker < ActiveRecord::Migration[7.0]
  def change
    add_column :code_breakers, :Available, :string
  end
end
