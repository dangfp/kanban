class Admin::DevelopersController < Admin::ApplicationController
  def index
    @developers = Developer.all
  end
end
