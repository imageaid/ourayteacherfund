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

class GrantReview < ApplicationRecord
  belongs_to :grant_request
  belongs_to :board_member, foreign_key: :user_id, inverse_of: :grant_reviews

  has_rich_text :thoughts

  delegate :name, :first_name, :last_name, :email, to: :board_member, prefix: true
end
