class AddNameToManagers < ActiveRecord::Migration
  def change
    add_column :managers, :name, :string
    add_index :managers, :name, unique: true
  end
end
