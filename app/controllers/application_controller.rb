#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_permission

  private 
    def check_permission
        "您无权限"
    end
end
