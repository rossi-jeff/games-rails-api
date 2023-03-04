class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :Word, limit: 30
      t.integer :Length, default: 0

      t.timestamps
    end
  end
end
