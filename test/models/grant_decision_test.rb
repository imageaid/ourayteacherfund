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

require "test_helper"

class GrantDecisionTest < ActiveSupport::TestCase
  def build_decision(feedback)
    GrantDecision.create!(
      grant_request: grant_requests(:one),
      user_id: users(:one).id,
      approved: true,
      amount_awarded: 100,
      awardee_feedback: feedback
    )
  end

  test "with_awardee_feedback includes decisions with feedback text" do
    decision = build_decision("<div>This grant changed my classroom.</div>")

    assert_includes GrantDecision.with_awardee_feedback, decision
  end

  test "with_awardee_feedback excludes decisions without feedback" do
    no_record = build_decision(nil)
    empty = build_decision("")
    blank_markup = build_decision("<div><br></div>")
    nbsp_only = build_decision("<div>&nbsp; </div>")

    scoped = GrantDecision.with_awardee_feedback
    [ no_record, empty, blank_markup, nbsp_only ].each do |decision|
      assert_not_includes scoped, decision
    end
  end
end
