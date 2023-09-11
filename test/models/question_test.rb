# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  active     :boolean
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
