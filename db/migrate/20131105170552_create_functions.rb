class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.string :name
      t.string :pattern
      t.boolean :operator

      t.timestamps
    end
  end
end
