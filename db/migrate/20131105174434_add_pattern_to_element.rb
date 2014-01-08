class AddPatternToElement < ActiveRecord::Migration
  def change
    add_column :elements, :pattern, :string
  end
end
