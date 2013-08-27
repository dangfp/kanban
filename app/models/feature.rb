# == Schema Information
#
# Table name: features
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feature < ActiveRecord::Base
  belongs_to :project
  has_many :issues, dependent: :destroy
  attr_accessible :name

  validates :name, presence: true, length: { maximum: 30 }
end
