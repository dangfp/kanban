class Issue < ActiveRecord::Base
  belongs_to :feature
  belongs_to :developer
  belongs_to :tester
  belongs_to :project

  attr_accessible :number, :self_summary, :self_test, :testing_status, :testing_summary, :title
end
