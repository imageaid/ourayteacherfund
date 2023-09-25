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
class Donor < User
  store_accessor :meta, :street_address, :city, :state, :postal, :website, :credit, :level

  has_many :donations, dependent: :nullify, foreign_key: :user_id, inverse_of: :donor
  accepts_nested_attributes_for :donations, reject_if: :all_blank, allow_destroy: true

  validates :credit, presence: true

  def last_donation
    donations.order('donations.created_at desc').first
  end

  def total_donated
    donations.sum(:amount)
  end

  def self.permitted_params
    %i[email first_name last_name role active street_address city state postal website credit level]
  end

  def self.levels
    [
      ['Teacher\'s Pet ($0-99)', 'Teacher\'s Pet'],
      ['Honor Society ($100-999)', 'Honor Society'],
      ['Deans List ($1000-4,999)', 'Deans List'],
      ['Cum Laude ($5,000-9,999)', 'Cum Laude'],
      ['Magna Cum Laude ($10,000-19,999)', 'Magna Cum Laude'],
      ['Summa Cum Laude ($20,000+)', 'Summa Cum Laude']
    ]
  end
end
