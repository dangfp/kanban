# == Schema Information
#
# Table name: issues
#
#  id              :integer          not null, primary key
#  feature_id      :integer
#  developer_id    :integer
#  tester_id       :integer
#  number          :string(255)
#  title           :string(255)
#  self_summary    :text
#  testing_status  :string(255)
#  testing_summary :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  project_id      :integer
#

require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
