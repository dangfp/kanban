#encoding: utf-8
class Admin::ApplicationController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!
  before_filter :check_permission

  private
    def check_permission
      redirect_to root_path, notice: "您无权访问后台" unless current_user.can_access_admin?
    end
end
