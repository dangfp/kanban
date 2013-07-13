class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.references :feature
      t.references :developer
      t.references :tester
      t.string :number
      t.string :title
      t.boolean :self_test
      t.text :self_summary
      t.string :testing_status
      t.text :testing_summary

      t.timestamps
    end
    add_index :issues, :feature_id
    add_index :issues, :developer_id
    add_index :issues, :tester_id
    add_index :issues, :self_test
    add_index :issues, :testing_status
  end
end
