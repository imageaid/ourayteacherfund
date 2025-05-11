# == Schema Information
#
# Table name: grant_reviews
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  grant_request_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_grant_reviews_on_grant_request_id  (grant_request_id)
#  index_grant_reviews_on_user_id           (user_id)
#

require "test_helper"

class GrantReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
