# == Schema Information
#
# Table name: grant_requests
#
#  id               :bigint           not null, primary key
#  amount_requested :decimal(, )
#  purpose          :integer          default("tuition")
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
class GrantRequest < ApplicationRecord
  belongs_to :applicant, foreign_key: :user_id, inverse_of: :grant_requests
  belongs_to :grant

  validates :amount_requested, presence: true
  validates :responses, presence: true

  attr_accessor :questions

  accepts_nested_attributes_for :applicant, allow_destroy: false

  enum purpose: { tuition: 0, travel: 1, other: 2 }

  delegate :name, :email, to: :applicant, prefix: true
  delegate :name, to: :grant, prefix: true
end
