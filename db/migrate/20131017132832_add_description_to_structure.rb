class AddDescriptionToStructure < ActiveRecord::Migration
  def change
    add_column :structures, :description, :text
  end
end
