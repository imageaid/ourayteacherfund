class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_navigation_pages

  def set_navigation_pages
    @navigation_pages = Page.where(navigation: true, welcome_content: false).order(:position)
  end

  def login_required
    redirect_to login_path unless logged_in?
  end
end
