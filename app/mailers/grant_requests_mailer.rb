class GrantRequestsMailer < ApplicationMailer
  def grant_request_email(grant_request=nil)
    @grant_request = grant_request
    @url = 'https://www.google.com'
    mail(to: @grant_request.applicant_email, cc: 'ourayteacherfund@gmail.com', bcc: 'craig.kaminsky@gmail.com', subject: 'Grant Request Received')
  end
end
