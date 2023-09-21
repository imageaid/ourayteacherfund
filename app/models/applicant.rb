# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                                  :bigint           not null, primary key
#  access_count_to_reset_password_page :integer          default(0)
#  active                              :boolean          default(TRUE)
#  crypted_password                    :string
#  email                               :string           not null
#  first_name                          :string
#  last_name                           :string
#  magic_login_email_sent_at           :datetime
#  magic_login_token                   :string
#  magic_login_token_expires_at        :datetime
#  meta                                :jsonb
#  name                                :string
#  remember_me_token                   :string
#  remember_me_token_expires_at        :datetime
#  reset_password_email_sent_at        :datetime
#  reset_password_token                :string
#  reset_password_token_expires_at     :datetime
#  role                                :integer          default("subscriber")
#  salt                                :string
#  slug                                :string           not null
#  type                                :string           default("User"), not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_magic_login_token     (magic_login_token)
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_slug                  (slug) UNIQUE
#
class Applicant < User
  store_accessor :meta, :applied_on, :status

  has_many :grant_requests, dependent: :destroy, foreign_key: :user_id, inverse_of: :applicant

  validates :applied_on, presence: true
  validates :first_name, length: { minimum: 1, maximum: 120 }, allow_blank: false
  validates :last_name, length: { minimum: 1, maximum: 120 }, allow_blank: false

  scope :current_requests, (lambda do
    where("users.meta ->> 'requested_for' = '#{SchoolYears.new.current_school_year}'")
  end)
  scope :by_school_year, (lambda do |school_year|
    where("users.meta ->> 'requested_for' = '#{school_year}'")
  end)

  def statuses
    %w[pending accepted rejected]
  end

  def self.permitted_params
    %i[email password password_confirmation first_name last_name role active applied_on requested_for status]
  end
end
