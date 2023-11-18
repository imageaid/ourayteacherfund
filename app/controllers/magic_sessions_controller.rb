# frozen_string_literal: true

class MagicSessionsController < ApplicationController

  def new
    user = User.load_from_magic_login_token(params[:token])
    redirect_to(root_path, alert: 'Login link expired. Please try again.') && return if user.blank?

    auto_login(user)
    after_login!(user)
    user.clear_magic_login_token!
    grant_request = user.grant_requests.order(created_at: :desc).first

    if grant_request.present?
      redirect_to edit_grant_request_path(grant_request), notice: 'Welcome!'
    else
      redirect_to new_grant_request_path, alter: 'We cannot find a grant request for you. If you want, you can create a new one.'
    end
  end
end
