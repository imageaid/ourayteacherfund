# == Schema Information
#
# Table name: question_responses
#
#  id             :bigint           not null, primary key
#  response       :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  application_id :bigint           not null
#  question_id    :bigint           not null
#
# Indexes
#
#  index_question_responses_on_application_id  (application_id)
#  index_question_responses_on_question_id     (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (application_id => applications.id)
#  fk_rails_...  (question_id => questions.id)
#
require "test_helper"

class QuestionResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
