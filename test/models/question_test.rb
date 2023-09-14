# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  active     :boolean
#  position   :integer          default(1)
#  question   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
