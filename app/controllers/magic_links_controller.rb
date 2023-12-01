# frozen_string_literal: true

class MagicLinksController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user
      @user.generate_magic_login_token!

      MagicLoginMailer.send_email(user: @user, request: request).deliver_now
      redirect_to root_path, notice: "Logon link sent!"
    else
      redirect_to root_path, alert: "Email not found"
    end
  end
end
