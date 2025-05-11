# == Schema Information
#
# Table name: grant_decisions
#
#  id               :integer          not null, primary key
#  grant_request_id :integer          not null
#  user_id          :integer          not null
#  approved         :boolean
#  amount_awarded   :decimal(, )
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_grant_decisions_on_grant_request_id  (grant_request_id)
#  index_grant_decisions_on_user_id           (user_id)
#

class GrantDecision < ApplicationRecord
  belongs_to :grant_request

  has_rich_text :awardee_feedback
end
