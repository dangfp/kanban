class AddSelfTestingStatusToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :self_testing_status, :string
  end
end
