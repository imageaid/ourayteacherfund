# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  active     :boolean
#  position   :integer          default(1)
#  question   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  belongs_to :grant
  has_many :question_responses, dependent: :nullify
  acts_as_list

  scope :for_grant_requests, -> { where(active: true).order(:position) }
end
