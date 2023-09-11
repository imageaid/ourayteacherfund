# frozen_string_literal: true

module Admin
  # manage donations
  class DonationsController < AdminController
    before_action :set_donation, only: %i[show edit update destroy]

    def index
      @pagy, @donations = pagy(Donation.all.order(created_at: :desc))
    end

    def show; end

    def new; end

    def edit; end

    def create; end

    def update; end

    def destroy; end

    private

      def set_donation
        @donation = Donation.find(params[:id])
      end
  end
end
