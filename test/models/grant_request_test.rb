# == Schema Information
#
# Table name: grant_requests
#
#  id               :bigint           not null, primary key
#  amount_requested :decimal(, )
#  responses        :jsonb
#  school_year      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  grant_id         :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_grant_requests_on_grant_id  (grant_id)
#  index_grant_requests_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (grant_id => grants.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class GrantRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end