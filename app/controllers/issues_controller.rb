#encoding: utf-8
class IssuesController < ApplicationController
  def index
    @issues = Issue.paginate(page: params[:page])
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(params[:issue])

    if @issue.save
      redirect_to @issue, notice: '测试用例添加成功.'
    else
      render action: 'new'
    end
  end
end
