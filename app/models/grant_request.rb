# == Schema Information
#
# Table name: grant_requests
#
#  id               :bigint           not null, primary key
#  amount_requested :decimal(, )
#  school_year      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_grant_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class GrantRequest < ApplicationRecord
  belongs_to :applicant, class_name: 'User', foreign_key: 'user_id', inverse_of: :grant_requests
  has_many :question_responses, dependent: :destroy
  has_many :questions, through: :question_responses

  accepts_nested_attributes_for :applicant, allow_destroy: false
end
