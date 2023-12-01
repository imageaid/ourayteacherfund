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
# Indexes
#
#  index_grants_on_active  (active) UNIQUE
#  index_grants_on_name    (name) UNIQUE
#
class Grant < ApplicationRecord
  has_many :grant_requests, dependent: :destroy

  validates :active, inclusion: {in: [true, false]}, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
