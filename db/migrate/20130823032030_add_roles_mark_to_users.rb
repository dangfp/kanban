class AddRolesMarkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :roles_mark, :integer
  end
end
