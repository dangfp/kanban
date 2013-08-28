#encoding: utf-8
class HomesController < ApplicationController
  def index

    if user_signed_in?
      if current_user.can_access_admin?
        @projects = Project.all
      elsif current_user.can_access_developer?
        @projects = Project.joins(:issues).where('issues.developer_id = ?', current_user.id).group(:id)
      elsif current_user.can_access_tester?
        @projects = Project.joins(:issues).where('issues.tester_id = ?', current_user.id).group(:id)
      end
    else
      @projects = Project.all
    end
    @results = {}
    @results = @projects.map {|project|
                                if user_signed_in?
                                  if current_user.can_access_admin?
                                   issues_count_of_project = project.issues.count

                                   new_issues_count_of_project = project.issues.where("self_testing_status = ?" , '未开发').count
                                   in_development_issues_count_of_project = project.issues.where("self_testing_status = ?" , '开发中').count
                                   self_tested_issues_count_of_project = project.issues.where("self_testing_status = ?", '自测通过').count

                                   not_test_issues_count_of_project = project.issues.where("testing_status = ?" , '未测试').count
                                   tested_successful_issues_count_of_project = project.issues.where("testing_status = ?" , '测试通过').count
                                   tested_fail_issues_count_of_project = project.issues.where("testing_status = ?" , '测试失败').count

                                  elsif current_user.can_access_developer?
                                   issues_count_of_project = project.issues.where(developer_id: current_user.id).count

                                   new_issues_count_of_project = project.issues.where(self_testing_status: '未开发', developer_id: current_user.id).count
                                   in_development_issues_count_of_project = project.issues.where(self_testing_status: '开发中', developer_id: current_user.id).count
                                   self_tested_issues_count_of_project = project.issues.where(self_testing_status: '自测通过', developer_id: current_user.id).count

                                   not_test_issues_count_of_project = project.issues.where(testing_status: '未测试', developer_id: current_user.id).count
                                   tested_successful_issues_count_of_project = project.issues.where(testing_status: '测试通过', developer_id: current_user.id).count
                                   tested_fail_issues_count_of_project = project.issues.where(testing_status: '测试失败', developer_id: current_user.id).count

                                  elsif current_user.can_access_tester?
                                   issues_count_of_project = project.issues.where(tester_id: current_user.id).count

                                   new_issues_count_of_project = project.issues.where(self_testing_status: '未开发', tester_id: current_user.id).count
                                   in_development_issues_count_of_project = project.issues.where(self_testing_status: '开发中', tester_id: current_user.id).count
                                   self_tested_issues_count_of_project = project.issues.where(self_testing_status: '自测通过', tester_id: current_user.id).count

                                   not_test_issues_count_of_project = project.issues.where(testing_status: '未测试', tester_id: current_user.id).count
                                   tested_successful_issues_count_of_project = project.issues.where(testing_status: '测试通过', tester_id: current_user.id).count
                                   tested_fail_issues_count_of_project = project.issues.where(testing_status: '测试失败', tester_id: current_user.id).count
                                  end
                                else

                                   issues_count_of_project = project.issues.count

                                   new_issues_count_of_project = project.issues.where("self_testing_status = ?" , '未开发').count
                                   in_development_issues_count_of_project = project.issues.where("self_testing_status = ?" , '开发中').count
                                   self_tested_issues_count_of_project = project.issues.where("self_testing_status = ?", '自测通过').count

                                   not_test_issues_count_of_project = project.issues.where("testing_status = ?" , '未测试').count
                                   tested_successful_issues_count_of_project = project.issues.where("testing_status = ?" , '测试通过').count
                                   tested_fail_issues_count_of_project = project.issues.where("testing_status = ?" , '测试失败').count
                                end

                                  {  project_name: project.name, 
                                     project_id: project.id,
                                     issues_count_of_project: issues_count_of_project,

                                     new_issues_count_of_project: new_issues_count_of_project,
                                     new_issues_rate: percents(new_issues_count_of_project, issues_count_of_project),
                                     in_development_issues_count_of_project: in_development_issues_count_of_project,
                                     in_development_issues_rate: percents(in_development_issues_count_of_project, issues_count_of_project),
                                     self_tested_issues_count_of_project: self_tested_issues_count_of_project,
                                     self_tested_issues_rate: percents(self_tested_issues_count_of_project, issues_count_of_project), 
                                  
                                    not_test_issues_count_of_project: not_test_issues_count_of_project,
                                    not_test_issues_rate: percents(not_test_issues_count_of_project, issues_count_of_project),
                                    tested_successful_issues_count_of_project: tested_successful_issues_count_of_project,
                                    tested_successful_issues_rate: percents(tested_successful_issues_count_of_project, issues_count_of_project),
                                    tested_fail_issues_count_of_project: tested_fail_issues_count_of_project,
                                    tested_fail_issues_rate: percents(tested_fail_issues_count_of_project, issues_count_of_project)
                                   }
                                 }
  end

  def percents(var1, var2)
    if var1 > 0 && var2 > 0
      (var1.to_f / var2.to_f * 100).round(2).to_s + '%'  
    else
      return 0  
    end
  end

end
