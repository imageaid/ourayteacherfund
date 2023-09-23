class GrantRequestsMailer < ApplicationMailer
  def grant_request_email(grant_request=nil)
    @grant_request = grant_request
    @url = 'https://www.google.com'
    mail(to: 'craig.kaminsky@gmail.com', bcc: 'ckaminsky@homeactions.net', subject: 'Grant Request Received')
  end
end
