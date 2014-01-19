class AddSingleUseToOperator < ActiveRecord::Migration
  def change
    add_column :operators, :single_use, :boolean
  end
end
