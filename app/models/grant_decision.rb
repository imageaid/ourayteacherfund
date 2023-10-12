# == Schema Information
#
# Table name: grant_decisions
#
#  id               :bigint           not null, primary key
#  amount_awarded   :decimal(, )
#  approved         :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  grant_request_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_grant_decisions_on_grant_request_id  (grant_request_id)
#  index_grant_decisions_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (grant_request_id => grant_requests.id)
#  fk_rails_...  (user_id => users.id)
#
class GrantDecision < ApplicationRecord
  belongs_to :grant_request
end
