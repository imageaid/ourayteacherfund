# == Schema Information
#
# Table name: donations
#
#  id          :bigint           not null, primary key
#  amount      :decimal(, )      default(0.0)
#  received_on :date
#  recurring   :boolean          default(FALSE)
#  thanked     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_donations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Donation < ApplicationRecord
  belongs_to :donor, foreign_key: :user_id, inverse_of: :donations

  attr_accessor :donor_id

  delegate :email, :name, to: :donor, prefix: true

  scope :recent_donors, (lambda do |limit_total|
    joins(:donor)
      .where("(users.meta ->> 'credit' = '1' OR users.meta ->> 'credit' = 'true')")
      .order(received_on: :desc)
      .limit(limit_total)
  end)
end
