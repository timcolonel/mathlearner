class CreateExpressions < ActiveRecord::Migration
  def change
    create_table :expressions do |t|
      t.string :name
      t.string :key
      t.references :parent

      t.timestamps
    end
  end
end
