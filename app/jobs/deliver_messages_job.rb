class DeliverMessagesJob < ApplicationJob
  queue_as :default

  def perform(message)
    failures = 0
    recipients = User.where("role IN (#{recipient_groups(deliver_to: message.deliver_to).join(',')})")
    recipients.each do |recipient|
      MessageMailer.transmit(message: message, recipient: recipient).deliver_later
    rescue StandardError => e
      Rails.logger.error "MESSAGE SEND ERROR: #{recipient.email}:#{message.subject} -- #{e.message}"
      failures += 1
    end
    message.update(status: :sent, total_delivered: recipients.size - failures)
  end

  private

    def recipient_groups(deliver_to:)
      group = []
      deliver_to.each do |role_group|
        if role_group == 'board'
          group << 'director'
          group << 'secretary'
          group << 'treasurer'
          group << 'vice_president'
          group << 'president'
        else
          group << role_group
        end
      end
      group
    end
end
