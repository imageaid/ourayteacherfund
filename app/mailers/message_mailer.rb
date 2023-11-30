class MessageMailer < ApplicationMailer
  default from: 'ourayteacherfund@gmail.com'

  def transmit(message:, recipient:)
    @message = message
    @recipient = recipient
    attachments.inline['logo.png'] = File.read('./public/images/ouray-teacher-fund-logo-128.png', mode: 'rb')
    mail(to: recipient, subject: message.subject)
  end
end
