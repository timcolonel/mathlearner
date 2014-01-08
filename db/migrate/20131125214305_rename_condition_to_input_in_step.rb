class RenameConditionToInputInStep < ActiveRecord::Migration
  def change
    rename_column :steps, :condition, :output
  end
end
