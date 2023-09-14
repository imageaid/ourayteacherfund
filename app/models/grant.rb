# == Schema Information
#
# Table name: grants
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  details    :text
#  name       :string
#  questions  :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Grant < ApplicationRecord
  has_many :grant_requests, dependent: :destroy
end
