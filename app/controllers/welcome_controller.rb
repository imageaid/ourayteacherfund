# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @donations = Donation.includes(:donor).order(created_at: :desc).limit(6)
    @page = Page.find_by(welcome_content: true)
    @pages = Page.where(navigation: true, welcome_content: false).order(:position)
  end
end
