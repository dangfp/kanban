#encoding: utf-8
class HomesController < ApplicationController
  def index
    @projects = Project.all

    @results = {}
    #Project.all.each do |project|
      @results = Project.all.map {|project| {project_name: project.name, 
                                             issues_count_of_project: project.issues.count,
                                             new_issues_count_of_project: project.issues.where("self_testing_status = ?" , '未开发').count,
                                             in_development_issues_count_of_project: project.issues.where("self_testing_status = ?" , "开发中").count,
                                             self_tested_issues_count_of_project: project.issues.where("self_testing_status = ?", '自测通过').count} }
    #end

    #  @result[issues_count_of_project] = project.issues.count
    #  @result[new_issues_count_of_project] = project.issues.where("self_testing_status = ?" , '未开发').count
    #  @result[in_development_issues_count_of_project] = project.issues.where("self_testing_status = ?", '开发中').count
    #  @result[self_tested_issues_count_of_project] = project.issues.where("self_testing_status = ?", '自测通过').count
    #  @percentage_of_new_issues = (@new_issues_count_of_project.round(2) / @issues_count_of_project.round(2) * 100).to_s + '%'
    #  @percentage_of_in_development_issues = (@in_development_issues_count_of_project.round(2) / @issues_count_of_project.round(2) * 100).to_s + '%'
    #  @percentage_of_self_tested_issues = (@self_tested_issues_count_of_project.round(2) / @issues_count_of_project.round(2) * 100).to_s + '%'
  end
end
