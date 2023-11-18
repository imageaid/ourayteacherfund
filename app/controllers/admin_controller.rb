# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :login_required

  layout 'admin'

  private

    def login_required
      redirect_to admin_sign_in_path, alert: 'You must be logged in to use the administration area' unless current_user
    end
end
