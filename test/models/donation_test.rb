# == Schema Information
#
# Table name: donations
#
#  id          :bigint           not null, primary key
#  amount      :decimal(, )      default(0.0)
#  received_on :date
#  recurring   :boolean          default(FALSE)
#  thanked     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_donations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class DonationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
