class DonorsController < ApplicationController

  def index
    @donors = Donor.where(credit: true).order(:last_name)
  end

  def show
    @donor = Donor.friendly.find(params[:id])
  end
end
