# Preview all emails at http://localhost:3000/rails/mailers/grant_requests_mailer
class GrantRequestsMailerPreview < ActionMailer::Preview
  def grant_request_email
    grant_request = GrantRequest.last
    GrantRequestsMailer.grant_request_email(grant_request)
  end
end
