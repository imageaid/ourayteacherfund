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
#  role                                :integer          default("guest")
#  salt                                :datetime
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
class User < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_name, use: :slugged

  has_many :applications, dependent: :nullify
  has_one_attached :avatar

  store_accessor :meta, :theme_preference

  authenticates_with_sorcery!

  enum role: { subscriber: 0, applicant: 1, donor: 2, director: 3, secretary: 4, treasurer: 5, vice_president: 6, president: 7 }

  validates :first_name, length: { minimum: 1, maximum: 120 }, allow_blank: true
  validates :last_name, length: { minimum: 1, maximum: 120 }, allow_blank: true
  validates :email, uniqueness: true, presence: { message: 'cannot be blank' }
  validates :password, length: { within: 6..30, message: 'cannot be blank' }, if: :password_required?
  validates :password, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  def generate_temp_password
    temp_password ||= SecureRandom.hex(10)
    self.password = temp_password
    self.password_confirmation = temp_password
  end

  private

    def slug_name
      if first_name.present? && last_name.present?
        "#{first_name} #{last_name}"
      else
        id.to_s
      end
    end

    def password_required?
      new_record? || password.present? || password_confirmation.present?
    end
end
