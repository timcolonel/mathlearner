class RemoveInputAndOutputFromAlgorithm < ActiveRecord::Migration
  def change
    remove_column :algorithms, :input, :string
    remove_column :algorithms, :output, :string
  end
end
