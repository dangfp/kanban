class HomesController < ApplicationController
  def index
    @issues = Issue.all
    @projects = Project.all
  end
end
