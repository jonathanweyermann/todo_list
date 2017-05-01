class CreateList < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :description
      t.integer :completion_units
    end
  end
end
