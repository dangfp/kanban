#encoding: utf-8
class IssuesController < ApplicationController
  def index
    # @issues = Issue.paginate(page: params[:page])

    @search = Issue.search(params[:q])
    @issues = @search.result.paginate(per_page: 1, page: params[:page])
    @issues = Issue.paginate(per_page: 1, page: params[:page])
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

    # @selected_project = Project.find_by_id(params[:project])

    # logger.info "selected_project#{@selected_project}"
#    @projects = Project.all

 #   @features = Feature.all
   
  end

#  def update_features
#    selected_project = Project.find(params[:project_id])
#    #binding.pry
#    @features = selected_project.features.map { |f| [f.id, f.name].insert(0, "请选择模块")  }
#  end

  def create

    @current_feature = Feature.find(params[:issue][:feature_id])
    params[:issue].delete(:feature_id)
    @issue = @current_feature.issues.build(params[:issue])

    if @issue.save
      redirect_to issues_path, notice: '测试用例添加成功.'
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
      redirect_to issues_path, notice: '修改测试用例成功'
    else
      render action: 'edit'
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    redirect_to issues_path, notice: '删除测试用例成功'
  end
end
