# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  deliver_to      :text             default([]), is an Array
#  message_type    :integer          default("email")
#  sends_at        :datetime
#  status          :integer          default("draft")
#  subject         :string
#  total_delivered :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Message < ApplicationRecord
  has_rich_text :body

  enum message_type: {email: 0, sms: 1}
  enum status: {draft: 0, scheduled: 1, sent: 2}
end
