class RemoveUserIdToIssue < ActiveRecord::Migration
  def change
    remove_column :issues, :user_id
  end

end
