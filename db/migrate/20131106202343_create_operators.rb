class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.string :name
      t.string :display_name
      t.string :pattern
      t.integer :priority

      t.timestamps
    end
  end
end
