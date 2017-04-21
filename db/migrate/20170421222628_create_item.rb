class CreateItem < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :percentage
      t.string :description
      t.references :list, foreign_key: true
    end
  end
end
