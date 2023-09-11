# == Schema Information
#
# Table name: applications
#
#  id               :bigint           not null, primary key
#  amount_requested :decimal(, )
#  other_purpose    :string
#  purpose          :integer
#  school_year      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_applications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Application < ApplicationRecord
  belongs_to :user
  has_many :question_responses
  has_many :questions, through: :question_responses
end
