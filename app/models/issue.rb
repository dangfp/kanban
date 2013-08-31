#encoding: utf-8
# == Schema Information
#
# Table name: issues
#
#  id              :integer          not null, primary key
#  feature_id      :integer
#  developer_id    :integer
#  tester_id       :integer
#  number          :string(255)
#  title           :string(255)
#  self_summary    :text
#  testing_status  :string(255)
#  testing_summary :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  project_id      :integer
#

class Issue < ActiveRecord::Base
#  include Workflow
#
#  workflow_column :testing_status
#  workflow do
#    state :new do
#      event :start_developing, :transitions_to => :in_developing
#    end
#    state :in_developing do
#      event :self_test, :transitions_to => :self_tested
#    end
#    state :self_tested do
#      event :pass, :transitions_to => :success
#      event :fail, :transitions_to => :failed
#      event :report, :transitions_to => :NA
#    end
#    state :success
#    state :failed do
#      event :restart, :transitions_to => :new
#    end
#    state :NA
#  end
  belongs_to :feature
  belongs_to :developer, class_name: User, foreign_key: 'developer_id' 
  belongs_to :tester, class_name: User, foreign_key: 'tester_id'
  belongs_to :project
#  belongs_to :user

  #attr_accessible :number, :self_summary, :self_test, :testing_status, :testing_summary, :title, :developer_id, :tester_id, :project_id
  attr_accessible :number, :title,:self_testing_status, :self_summary, :self_test, :testing_status,
                  :testing_summary,:developer_id, :tester_id, :project_id, :feature_id

  validates :number, presence: true, length: { maximum: 10 }
  validates :title,:number, presence: true, length: { maximum: 30 }
  validates :testing_summary, length: { maximum: 50}
  validates :self_summary, length: { maximum: 50}

  #export csv
  def self.to_csv(options = {})
     CSV.generate(options) do |csv|
       csv << column_names
       all.each do |issue|
        csv << issue.attributes.values_at(*column_names)
      end
    end
  end


  #import excel
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      issue = find_by_id(row["id"]) || new
      issue.attributes = row.to_hash.slice(*accessible_attributes)
      issue.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unkown file type: #{file.original_filename}"
    end
  end

end
