class IssuesController < ApplicationController
  def index
    @issues = Issue.paginate(page: params[30])
  end
end
