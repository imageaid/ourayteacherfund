# frozen_string_literal: true

class DeliverMessagesJob < ApplicationJob
  queue_as :default

  def perform(message)
    failures = 0
    recipients = User.where("role IN (#{recipient_groups(deliver_to: message.deliver_to).join(",")})")
    recipients.each do |recipient|
      MessageMailer.transmit(message:, recipient:).deliver_later
    rescue => e
      Rails.logger.error "MESSAGE SEND ERROR: #{recipient.email}:#{message.subject} -- #{e.message}"
      failures += 1
    end
    message.update(status: :sent, total_delivered: recipients.size - failures)
  end

  private

  def recipient_groups(deliver_to:)
    group = []
    deliver_to.each do |role_group|
      group << case role_group
      when "board"
        [3, 4, 5, 6, 7]
      when "applicants"
        1
      when "donors"
        2
      else
        0
      end
    end
    group.flatten
  end
end
