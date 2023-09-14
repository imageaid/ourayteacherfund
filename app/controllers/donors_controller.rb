class DonorsController < ApplicationController

  def index
    @donors = Donor.where("(users.meta ->> 'credit' = '1' OR users.meta ->> 'credit' = 'true')")
                   .order(:last_name, :first_name)
  end
end
