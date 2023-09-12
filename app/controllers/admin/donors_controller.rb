# frozen_string_literal: true

module Admin
  # manage donors
  class DonorsController < AdminController
    before_action :set_donor, only: %i[ show edit update destroy ]

    def index
      @donors = Donor.all
    end

    def show; end

    def new
      @donor = Donor.new
      @donor.donations.build
      # @donor.donations << Donation.new
    end

    def edit
      @donor.donations.build
    end

    def create
      @donor = Donor.new(donor_params)

      if @donor.save
        redirect_to admin_donor_url(@donor), notice: 'Donor was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @donor.update(donor_params)
        redirect_to admin_donor_url(@donor), notice: 'Donor was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @donor.destroy

      respond_to do |format|
        format.html { redirect_to admin_donors_url, notice: 'Donor was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

      def set_donor
        @donor = Donor.friendly.find(params[:id])
      end

      def donor_params
        params.require(:donor).permit(
          :first_name, :last_name, :email, :street_address, :city, :state, :postal, :website, :credit,
          donations_attributes: %i[id amount received_on recurring thanked _destroy]
        )
      end
  end
end
