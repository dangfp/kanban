#encoding: utf-8
class IssuesController < ApplicationController
#  before_filter :authenticate_developer! 
#  before_filter :authenticate_tester!

  def index
      if params[:project_id] != nil
        cookies[:project_name] = params[:project_name]
        cookies[:project_id] = params[:project_id]
        
      end
      @search = Issue.search(params[:q])
      @results = @search.result
      @issues = @results.where(project_id: cookies[:project_id]).paginate(page: params[:page], per_page: 50)
      @issues = Issue.where(project_id: cookies[:project_id]).paginate(page: params[:page], per_page: 50) unless params[:q]
  end

  
  def show 
    #debugger

    @issue = Issue.find(params[:id])
  end

  def new
    @issue = Issue.new
    @result = {}
    Project.all.each do |project|
      @result[project.id] = project.features.map {|feature| {id: feature.id, name: feature.name} }
    end
  end


  def create

    @current_feature = Feature.find(params[:issue][:feature_id])
    params[:issue].delete(:feature_id)
    @issue = @current_feature.issues.build(params[:issue])

    if @issue.save
      redirect_to issues_path(project_id: cookies[:project_id], project_name: cookies[:project_name]), notice: '测试用例添加成功.'
    else
      render action: 'new'
    end
  end

  def edit
    @issue = Issue.find(params[:id])

    @result = {}
    Project.all.each do |project|
      @result[project.id] = project.features.map { |feature| {id: feature.id, name: feature.name} }
    end
  end

  def update
    @issue = Issue.find(params[:id])

    params[:issue].delete(:feature_id)
    if @issue.update_attributes(params[:issue])
      redirect_to issues_path(project_id: cookies[:project_id], project_name: cookies[:project_name]), notice: '修改测试用例成功'
    else
      render action: 'edit'
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    redirect_to issues_path(project_id: cookies[:project_id],project_name: cookies[:project_name]), notice: '删除测试用例成功'
  end

  def import
    Issue.import(params[:file])
    redirect_to issues_path, notice: "Issue imported."
  end
end
