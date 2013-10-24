class AddHelperToExpression < ActiveRecord::Migration
  def change
    add_column :expressions, :helper, :boolean
  end
end
