# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  active     :boolean
#  question   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  has_many :question_responses
end
