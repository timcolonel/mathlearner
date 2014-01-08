class CreateTestHeuristicDataFinals < ActiveRecord::Migration
  def change
    create_table :test_heuristic_data_finals do |t|
      t.string :value

      t.timestamps
    end
  end
end
