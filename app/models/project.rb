class Project < ActiveRecord::Base
  attr_accessible :name

  has_many :features
  has_many :issues
end
