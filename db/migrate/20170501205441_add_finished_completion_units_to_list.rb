class AddFinishedCompletionUnitsToList < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :finished_completion_units, :integer, default: 0
  end
end
