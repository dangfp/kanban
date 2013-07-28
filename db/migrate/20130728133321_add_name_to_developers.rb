class AddNameToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :name, :string
    add_index :developers, :name, unique: true
  end
end
