class Admin::DevelopersController < Admin::ApplicationController
  def index
    @developers = Developer.all
  end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(params[:developer])
    if @developer.save!
       redirect_to admin_developers
    else
       render :new
    end
  end

  def edit
    @developer = Developer.find(params[:id])
  end

  def destroy
  end
end
