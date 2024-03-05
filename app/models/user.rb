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
class User < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_name, use: :slugged

  authenticates_with_sorcery!

  has_many :grant_requests, dependent: :nullify
  has_one_attached :avatar

  # before_save :encrypt_password

  attr_accessor :quiz
  store_accessor :meta, :theme_preference

  enum role: {subscriber: 0, applicant: 1, donor: 2, director: 3, secretary: 4, treasurer: 5, vice_president: 6, president: 7}

  validates :first_name, length: {minimum: 1, maximum: 120}, allow_blank: true
  validates :last_name, length: {minimum: 1, maximum: 120}, allow_blank: true
  validates :email, uniqueness: true, presence: {message: "cannot be blank"}
  validates :password, length: {within: 6..30, message: "cannot be blank"}, if: :password_required?
  validates :password, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  normalizes :email, with: ->(email) { email.downcase.strip }

  scope :filter_by, lambda { |params|
    query = self
    params.each do |key, value|
      query = query.send("with_#{key}", value)
    end
    query
  }
  scope :with_first_name, ->(name) { where("lower(first_name) LIKE ?", "%#{name.downcase.strip}%") if name.present? }
  scope :with_last_name, ->(name) { where("lower(last_name) LIKE ?", "%#{name.downcase.strip}%") if name.present? }
  scope :with_email, ->(email) { where("lower(email) LIKE ?", "%#{email.downcase.strip}%") if email.present? }

  def generate_temp_password
    temp_password ||= SecureRandom.hex(10)
    self.password = temp_password
    self.password_confirmation = temp_password
  end

  def board_member?
    %w[director secretary treasurer vice_president president].include?(role)
  end

  def applyable?
    %w[subscriber applicant].include?(role)
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

  # def encrypt_password
  #   return if password.blank?
  #
  #   self.salt = Sorcery::Model::TemporaryToken.generate_random_token
  #   p "SALT: #{salt}"
  #   self.crypted_password = Sorcery::CryptoProviders::BCrypt.encrypt(password, salt)
  # end
end
