# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  attr_accessible :name
  
  # validates :name, presence: true

  has_many :features, dependent: :destroy
  has_many :issues, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }

end
