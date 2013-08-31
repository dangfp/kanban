#encoding: utf-8
class IssuesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
      if params[:project_id] != nil
        cookies[:project_name] = params[:project_name]
        cookies[:project_id] = params[:project_id]
        
      end

      @search = Issue.search(params[:q])
      @results = @search.result
      @issues = @results.where(project_id: cookies[:project_id]).paginate(page: params[:page], per_page: 50)
      @issues = Issue.where(project_id: cookies[:project_id]).paginate(page: params[:page], per_page: 50) unless params[:q]

      if user_signed_in?
        if current_user.can_access_developer?
          @issues = @results.where(project_id: cookies[:project_id],developer_id: current_user.id).paginate(page: params[:page], per_page: 50)
          @issues = Issue.where(project_id: cookies[:project_id],developer_id: current_user.id).paginate(page: params[:page], per_page: 50) unless params[:q]
        elsif current_user.can_access_tester?
          @issues = @results.where(project_id: cookies[:project_id],tester_id: current_user.id).paginate(page: params[:page], per_page: 50)
          @issues = Issue.where(project_id: cookies[:project_id],tester_id: current_user.id).paginate(page: params[:page], per_page: 50) unless params[:q]
        end
      end

      #export csv
      respond_to do |format|
        format.html
        format.xls # { send_data @issues.to_csv(col_sep: "\t") }
        #format.xls
      end
  end


  def new
    @issue = Issue.new

    #新建issue时，设置初始默认值
    @issue.self_testing_status = "未开发"
    @issue.testing_status = "未测试"
    @issue.developer = User.where('roles_mask = ?', (User.mask_for :developer)).first
    @issue.tester= User.where('roles_mask = ?', (User.mask_for :tester)).first
    

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
