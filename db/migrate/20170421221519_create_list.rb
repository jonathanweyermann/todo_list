class CreateList < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.integer :completion_units
    end
  end
end
