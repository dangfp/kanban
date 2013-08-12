# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  attr_accessible :name

  has_many :features
  has_many :issues

#统计数字定义
#  define_statistic :total_issues_count, count: :all
#  define_statistic :issues_count_of_project, count: :all, column_name: 'project.id', joins: :issue
#  define_statistic :throughput_issues_count_of_project, count: :all,-
#                    conditions: "testing_status = √√", column_name: 'project.id', joins: :issue
#  define_statistic :faileput_issues_count_of_project, count: :all,
#                    conditions: "testing_status = ×",column_name: 'project.id', joins: :issue
#  define_calculated_statistic :throughput_rate do
#    defined_stats(:throughput_issues_count_of_project) / defined_stats(:issues_count_of_project)
#  end
end
