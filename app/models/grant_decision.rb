# == Schema Information
#
# Table name: grant_decisions
#
#  id               :integer          not null, primary key
#  grant_request_id :integer          not null
#  user_id          :integer          not null
#  approved         :boolean
#  amount_awarded   :decimal(, )
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_grant_decisions_on_grant_request_id  (grant_request_id)
#  index_grant_decisions_on_user_id           (user_id)
#

class GrantDecision < ApplicationRecord
  belongs_to :grant_request

  has_rich_text :awardee_feedback

  # Decisions whose awardee feedback has visible text. An empty Trix editor can
  # still save markup like "<div><br></div>", so strip tags and &nbsp; before
  # checking for any non-whitespace character.
  scope :with_awardee_feedback, lambda {
    joins(:rich_text_awardee_feedback)
      .where("regexp_replace(action_text_rich_texts.body, '<[^>]*>|&nbsp;', '', 'g') ~ '\\S'")
  }
end
