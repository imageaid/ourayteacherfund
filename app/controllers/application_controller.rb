class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pagy::Backend

  before_action :set_navigation_pages

  def set_navigation_pages
    @navigation_pages = Page.where(navigation: true, welcome_content: false).order(:position)
  end

  def login_required
    redirect_to new_magic_link_path, alert: "You must be logged in to use this page" unless logged_in?
  end
end
