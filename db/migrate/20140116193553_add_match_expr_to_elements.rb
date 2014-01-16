class AddMatchExprToElements < ActiveRecord::Migration
  def change
    add_column :elements, :match_expr, :boolean
  end
end
