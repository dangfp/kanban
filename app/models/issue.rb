class Issue < ActiveRecord::Base
  include Workflow

  workflow_column :testing_status
  workflow do
    state :new do
      event :start_developing, :transitions_to => :in_developing
    end
    state :in_developing do
      event :self_test, :transitions_to => :self_tested
    end
    state :self_tested do
      event :pass, :transitions_to => :success
      event :fail, :transitions_to => :failed
      event :report, :transitions_to => :NA
    end
    state :success
    state :failed do
      event :restart, :transitions_to => :new
    end
    state :NA
  end
  belongs_to :feature
  belongs_to :developer
  belongs_to :tester
  belongs_to :project

  attr_accessible :number, :self_summary, :self_test, :testing_status, :testing_summary, :title
end
