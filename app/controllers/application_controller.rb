#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

#  rescue_from CanCan::AccessDenied, with: :no_permission_error
#
  private
    def no_permission_error
#      flash[:error] = '您的访问权限不足'
#      redirect_to issues_path(project_id: cookies[:project_id], project_name: cookies[:project_name])
      redirect_to issues_path(project_id: cookies[:project_id], project_name: cookies[:project_name]), notice: "您的权限不够"
    end
end
