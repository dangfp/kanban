class Admin::ProjectsController < Admin::ApplicationController
  def index 
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    
    if @project.save!
      redirect_to admin_projects
    end
  end
end