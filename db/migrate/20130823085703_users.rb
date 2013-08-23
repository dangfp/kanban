class Users < ActiveRecord::Migration
  def self.up
    rename_column :users, :roles_mark, :roles_mask
  end

  def down
  end
end
