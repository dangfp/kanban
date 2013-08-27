#encoding: utf-8
class Admin::ProjectsController < Admin::ApplicationController
  def index 
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    
    if @project.save
      redirect_to admin_projects_path, notice: '项目添加成功'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to admin_projects_path, notice: '项目修改成功'
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to admin_projects_path
  end
end
