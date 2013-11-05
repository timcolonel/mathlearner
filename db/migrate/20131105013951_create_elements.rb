class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :name
      t.string :key
      t.integer :priority

      t.timestamps
    end
  end
end
