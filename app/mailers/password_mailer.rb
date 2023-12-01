# frozen_string_literal: true

class PasswordMailer < ApplicationMailer
  def reset_password(user)
    @user = user
    mail to: user.email, subject: "Reset your password"
  end
end
