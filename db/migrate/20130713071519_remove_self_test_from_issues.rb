class RemoveSelfTestFromIssues < ActiveRecord::Migration
  def up
    remove_column :issues, :self_test
  end

  def down
    add_column :issues, :self_test, :boolean
  end
end
