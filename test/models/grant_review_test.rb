# == Schema Information
#
# Table name: grant_reviews
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  grant_request_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_grant_reviews_on_grant_request_id  (grant_request_id)
#  index_grant_reviews_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (grant_request_id => grant_requests.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class GrantReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
