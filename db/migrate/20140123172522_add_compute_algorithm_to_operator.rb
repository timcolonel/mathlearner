class AddComputeAlgorithmToOperator < ActiveRecord::Migration
  def change
    add_column :operators, :compute_algorithm, :text
    add_column :functions, :compute_algorithm, :text
  end
end
