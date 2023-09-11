# == Schema Information
#
# Table name: pages
#
#  id              :bigint           not null, primary key
#  keywords        :string
#  link_label      :string
#  navigation      :boolean          default(FALSE)
#  position        :integer
#  slug            :string
#  title           :string
#  welcome_content :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_pages_on_link_label  (link_label) UNIQUE
#  index_pages_on_slug        (slug) UNIQUE
#  index_pages_on_title       (title) UNIQUE
#
class Page < ApplicationRecord
  extend FriendlyId
  has_rich_text :body

  validates :title, presence: true, uniqueness: true
  friendly_id :title, use: :slugged
end
