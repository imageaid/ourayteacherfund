module ApplicationHelper
  include Pagy::Frontend

  def css_class_for_flash(flash_type)
    {
      success: 'green',
      error: 'red',
      alert: 'red',
      notice: 'indigo'
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def external_donation_url
    Rails.application.config.external_donation_url
  end

  def us_states
    [
      %w[Alabama AL],
      %w[Alaska AK],
      %w[Arizona AZ],
      %w[Arkansas AR],
      %w[California CA],
      %w[Colorado CO],
      %w[Connecticut CT],
      %w[Delaware DE],
      ['District of Columbia', 'DC'],
      %w[Florida FL],
      %w[Georgia GA],
      %w[Hawaii HI],
      %w[Idaho ID],
      %w[Illinois IL],
      %w[Indiana IN],
      %w[Iowa IA],
      %w[Kansas KS],
      %w[Kentucky KY],
      %w[Louisiana LA],
      %w[Maine ME],
      %w[Maryland MD],
      %w[Massachusetts MA],
      %w[Michigan MI],
      %w[Minnesota MN],
      %w[Mississippi MS],
      %w[Missouri MO],
      %w[Montana MT],
      %w[Nebraska NE],
      %w[Nevada NV],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      %w[Ohio OH],
      %w[Oklahoma OK],
      %w[Oregon OR],
      %w[Pennsylvania PA],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      %w[Tennessee TN],
      %w[Texas TX],
      %w[Utah UT],
      %w[Vermont VT],
      %w[Virginia VA],
      %w[Washington WA],
      ['West Virginia', 'WV'],
      %w[Wisconsin WI],
      %w[Wyoming WY]
    ]
  end

  def current_school_year
    SchoolYears.new.current_school_year
  end

  def applications_open?
    right_now = Time.zone.now
    apps_starts = Date.new(right_now.year, 9, 1)
    apps_ends = Date.new(right_now.year + 1, 5, 1)
    right_now.between?(apps_starts, apps_ends)
  end
end
