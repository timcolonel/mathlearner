class CreateTestHeuristicData < ActiveRecord::Migration
  def change
    create_table :test_heuristic_data do |t|
      t.string :value
      t.references :final, index: true
      t.integer :order

      t.timestamps
    end
  end
end
