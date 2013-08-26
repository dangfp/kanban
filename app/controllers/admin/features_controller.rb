#encoding: utf-8
class Admin::FeaturesController < Admin::ApplicationController
  def index

    cookies[:project_id] = params[:project_id] unless params[:project_id] == nil
    @features = Feature.where(project_id: cookies[:project_id]).paginate(page: params[:page], per_page: 10).order('id ASC')
  end

  def new
    @feature = Feature.new
  end

  def create
    @feature = Feature.new(params[:feature])
    @feature.project_id = cookies[:project_id]

    if @feature.save!
      redirect_to admin_project_features_path(project_id: cookies[:project_id])
    else
      render 'new'
    end
  end

  def edit
    @feature = Feature.find(params[:id])
  end

  def update
    @feature = Feature.find(params[:id])
    if @feature.update_attributes(params[:feature])
      redirect_to admin_project_features_path(project_id: cookies[:project_id]), notice: '模块修改成功'
    else
      render 'edit'
    end
  end

  

  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy
    redirect_to admin_project_features_path(project_id: cookies[:project_id])
  end
end
