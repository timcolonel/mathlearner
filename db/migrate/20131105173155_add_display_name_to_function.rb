class AddDisplayNameToFunction < ActiveRecord::Migration
  def change
    add_column :functions, :display_name, :string
  end
end
