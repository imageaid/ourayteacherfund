module ApplicationHelper
  include Pagy::Frontend

  def css_class_for_flash(flash_type)
    {
      success: 'green',
      error: 'red',
      alert: 'orange',
      notice: 'blue'
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def external_donation_url
    Rails.application.config.external_donation_url
  end
end
