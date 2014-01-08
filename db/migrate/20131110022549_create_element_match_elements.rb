class CreateElementMatchElements < ActiveRecord::Migration
  def change
    create_table :element_match_elements do |t|
      t.references :element, index: true
      t.references :match, index: true
    end
  end
end
