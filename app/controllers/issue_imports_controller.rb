#encoding: utf-8
class IssueImportsController < ApplicationController
  def new
    @issue_import = IssueImport.new
  end

  def create
    @issue_import = IssueImport.new(params[:issue_import])
    if @issue_import.save
      redirect_to issues_path(project_id: cookies[:project_id],project_name: cookies[:project_name]), notice: "测试用例导入成功"
    else
      render 'new'
    end
  end
end
