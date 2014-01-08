class CreateAlgorithmSources < ActiveRecord::Migration
  def change
    create_table :algorithm_sources do |t|
      t.text :content
      t.references :algorithm, index: true

      t.timestamps
    end
  end
end
