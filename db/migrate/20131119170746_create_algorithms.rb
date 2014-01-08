class CreateAlgorithms < ActiveRecord::Migration
  def change
    create_table :algorithms do |t|
      t.string :name
      t.string :input
      t.string :output
      t.integer :priority

      t.timestamps
    end
  end
end
