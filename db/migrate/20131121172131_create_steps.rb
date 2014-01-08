class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :value
      t.references :parent, index: true
      t.boolean :condition
      t.references :algorithm, index: true

      t.timestamps
    end
  end
end
