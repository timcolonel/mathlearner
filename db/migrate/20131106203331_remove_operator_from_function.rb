class RemoveOperatorFromFunction < ActiveRecord::Migration
  def change
    remove_column :functions, :operator, :boolean
  end
end
