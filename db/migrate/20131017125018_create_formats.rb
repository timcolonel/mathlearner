class CreateFormats < ActiveRecord::Migration
  def change
    create_table :structures do |t|
      t.references :formattable, :polymorphic => true
      t.string :pattern

      t.timestamps
    end
  end
end
