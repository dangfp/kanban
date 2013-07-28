#encoding: utf-8
class IssuesController < ApplicationController
  def index
    @issues = Issue.paginate(page: params[:page])
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

  def update_features
    selected_project = Project.find(params[:project_id])
    #binding.pry
    @features = selected_project.features.map { |f| [f.id, f.name].insert(0, "请选择模块")  }
  end

  def create
    # @issue = Issue.new(params[:issue])

#    debugger


    @current_feature = Feature.find(params[:issue][:feature_id])
    params[:issue].delete(:feature_id)
    @issue = @current_feature.issues.build(params[:issue])

    if @issue.save
      redirect_to @issue, notice: '测试用例添加成功.'
    else
      render action: 'new'
    end
  end
end
