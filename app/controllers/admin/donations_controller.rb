# frozen_string_literal: true

module Admin
  class DonationsController < AdminController
    before_action :load_donation, only: %i[edit update]

    def create
      @donation = Donation.new(donation_params)
      @donation.save
      @donor = @donation.donor
      flash[:notice] = 'Donation updated. Thank you!' unless @donation.persisted?
      @donation = Donation.new(donor: @donor) unless @donation.persisted?
      flash[:alert] = @donation.errors.full_messages.join(', ') if @donation.errors.any?
    end

    def edit
      @donor = @donation.donor
    end

    def update
      @donor = @donation.donor
      @donation.update(donation_params)
      flash[:notice] = 'Donation updated. Thank you!' if @donor.errors.empty?
      @donation = Donation.new(donor: @donor) if @donor.errors.empty?
      flash[:alert] = @donation.errors.full_messages.join(', ') if @donation.errors.any?
      render :create
    end

    private

      def load_donation
        @donation = Donation.find(params[:id])
      end

      def donation_params
        params.require(:donation).permit(:amount, :donor_id, :user_id, :recurring, :received_on, :thanked)
      end
  end
end
