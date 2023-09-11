# frozen_string_literal: true

class MagicLoginMailer < ApplicationMailer
  def generate
    @user = params[:user]
    @token = params[:token]
    mail to: @user.email, subject: 'Login to your account'
  end
end
