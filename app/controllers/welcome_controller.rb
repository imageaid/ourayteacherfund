# frozen_string_literal: true

class WelcomeController < ApplicationController
  layout "welcome"

  def index
    @donations = Donation.recent_donors(4)
    @awardees = GrantDecision.where(approved: true).order(created_at: :desc).limit(4)
    @page = Page.find_by(welcome_content: true)
    @pages = Page.where(navigation: true, welcome_content: false).order(:position)
  end
end
