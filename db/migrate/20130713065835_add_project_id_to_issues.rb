class AddProjectIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :project_id, :integer
    add_index :issues, :project_id
  end
end
