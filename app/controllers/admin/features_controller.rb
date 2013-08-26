class Admin::FeaturesController < Admin::ApplicationController
  def index
    @features = Feature.all
  end
end
