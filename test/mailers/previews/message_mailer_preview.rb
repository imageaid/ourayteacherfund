# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview
  def transmit
    message = Message.last
    recipient = User.last
    MessageMailer.transmit(message: message, recipient: recipient)
  end
end
