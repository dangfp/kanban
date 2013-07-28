class AddNameToTesters < ActiveRecord::Migration
  def change
    add_column :testers, :name, :string
    add_index :testers, :name, unique: true
  end
end
