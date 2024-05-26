# == Schema Information
#
# Table name: grant_requests
#
#  id                :bigint           not null, primary key
#  amount_requested  :decimal(, )
#  other_data        :text
#  purpose           :integer          default("tuition")
#  responses         :jsonb
#  school_year       :string
#  slug              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  grant_decision_id :bigint
#  grant_id          :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_grant_requests_on_grant_decision_id  (grant_decision_id)
#  index_grant_requests_on_grant_id           (grant_id)
#  index_grant_requests_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (grant_decision_id => grant_decisions.id)
#  fk_rails_...  (grant_id => grants.id)
#  fk_rails_...  (user_id => users.id)
#
class GrantRequest < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_name, use: :slugged

  belongs_to :applicant, foreign_key: :user_id, inverse_of: :grant_requests
  belongs_to :grant

  has_one :grant_decision, dependent: :destroy
  has_many :grant_reviews, dependent: :destroy

  validates :amount_requested, presence: true
  validates :responses, presence: true

  attr_accessor :questions

  accepts_nested_attributes_for :applicant, allow_destroy: false

  enum purpose: {tuition: 0, travel: 1, other: 2}

  delegate :first_name, :last_name, :email, to: :applicant
  delegate :name, to: :grant, prefix: true

  scope :filter_by, lambda { |params|
    query = self
    params.each do |key, value|
      query = query.send("with_#{key}", value)
    end
    query
  }
  scope :with_first_name, ->(name) { joins(:applicant).where("lower(users.first_name) LIKE ?", "%#{name.downcase.strip}%") if name.present? }
  scope :with_last_name, ->(name) { joins(:applicant).where("lower(users.last_name) LIKE ?", "%#{name.downcase.strip}%") if name.present? }
  scope :with_email, ->(email) { joins(:applicant).where("lower(users.email) LIKE ?", "%#{email.downcase.strip}%") if email.present? }

  def applicant_name
    "#{first_name} #{last_name}"
  end

  private

  def slug_name
    if last_name.present?
      "#{last_name} #{paramaterized_email(email)} #{id}"
    else
      id.to_s
    end
  end

  def paramaterized_email(email)
    raw_email_name = email.present? ? email[/[^@]+/] : "-"
    raw_email_name.gsub(/\p{Punct}/, "")
  end
end
