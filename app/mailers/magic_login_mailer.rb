# frozen_string_literal: true

class MagicLoginMailer < ApplicationMailer
  def send_email(user:, request:)
    @user = user
    @url = new_magic_session_url(token: @user.magic_login_token, host: request.host_with_port)
    mail to: @user.email, subject: "Login link to your account"
  end
end
